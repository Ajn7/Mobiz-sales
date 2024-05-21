import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobizapp/Pages/homepage.dart';
import 'package:mobizapp/Pages/selectProducts.dart';

import '../Components/commonwidgets.dart';
import '../Models/appstate.dart';
import '../Models/stockdata.dart';
import '../Utilities/rest_ds.dart';
import '../confg/appconfig.dart';
import '../confg/sizeconfig.dart';

class VanStocks extends StatefulWidget {
  static const routeName = "VanStocks";
  const VanStocks({super.key});

  @override
  State<VanStocks> createState() => _VanStocksState();
}

class _VanStocksState extends State<VanStocks> {
  final TextEditingController _searchData = TextEditingController();
  bool _initDone = false;
  List<Map<String, dynamic>> stocks = [];
  bool _search = false;
  String selectedValue = "PCS";

  @override
  void initState() {
    super.initState();
    _getStockData();
  }

  // @override
  // void dispose() {
  //   StockHistory.clearAllStockHistory();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        StockHistory.clearAllStockHistory();
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: AppConfig.backButtonColor),
            title: const Text('Van Stocks Requests',
                style: TextStyle(color: AppConfig.backButtonColor)),
            backgroundColor: AppConfig.colorPrimary,
            actions: [
              CommonWidgets.horizontalSpace(1),
              GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.pushReplacementNamed(
                        context, SelectProductsScreen.routeName);
                  });
                },
                child: Icon(
                  (!_search) ? Icons.search : Icons.close,
                  size: 30,
                  color: AppConfig.backgroundColor,
                ),
              ),
              CommonWidgets.horizontalSpace(3),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: SizedBox(
            width: SizeConfig.blockSizeHorizontal * 25,
            height: SizeConfig.blockSizeVertical * 5,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                backgroundColor:
                    const MaterialStatePropertyAll(AppConfig.colorPrimary),
              ),
              onPressed: () {
                if (stocks.isNotEmpty) {
                  _setProducts();
                }
              },
              child: Text(
                'SAVE',
                style: TextStyle(
                    fontSize: AppConfig.textCaption3Size,
                    color: AppConfig.backgroundColor,
                    fontWeight: AppConfig.headLineWeight),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  _initDone
                      ? SizedBox(
                          height: SizeConfig.blockSizeVertical * 80,
                          child: ListView.separated(
                            itemCount: stocks.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return _stockCard(stocks[index]);
                            },
                            separatorBuilder: (context, index) {
                              return CommonWidgets.verticalSpace(1);
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          )),
    );
  }

  Future<void> _getStockData() async {
    stocks = await StockHistory.getStockHistory();
    debugPrint('History Stocks ${stocks}');

    setState(() {
      _initDone = true;
    });
  }

  Widget _stockCard(Map<dynamic, dynamic> data) {
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(5),
        width: SizeConfig.blockSizeHorizontal * 90,
        height: SizeConfig.blockSizeVertical * 9,
        decoration: const BoxDecoration(
          color: AppConfig.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ListTile(
          title: Text(data['code'],
              style: TextStyle(fontSize: AppConfig.textCaption2Size)),
          subtitle: Text(
            data['name'],
            style: TextStyle(fontSize: AppConfig.textCaption3Size),
          ),
          trailing:
              //Text(data['quantity'].toString()),
              SizedBox(
            width: SizeConfig.blockSizeHorizontal * 45,
            child: Row(
              children: [
                DropdownButton(
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: dropdownItems),
                CommonWidgets.horizontalSpace(2),
                Text(
                  data['quantity'].toString(),
                  style: const TextStyle(fontSize: 16),
                ),
                CommonWidgets.horizontalSpace(3),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            if (data['quantity'] > 1) {
                              data['quantity'] = data['quantity'] - 1;
                            }
                          },
                        );
                      },
                      child: CircleAvatar(
                        radius: 9,
                        backgroundColor: Colors.red,
                        child: Center(
                          child: Text('-',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppConfig.backgroundColor,
                                  fontWeight: AppConfig.headLineWeight)),
                        ),
                      ),
                    ),
                    CommonWidgets.verticalSpace(2),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          data['quantity'] = data['quantity'] + 1;
                        });
                      },
                      child: const CircleAvatar(
                        radius: 9,
                        backgroundColor: Colors.green,
                        child: Center(
                          child: Icon(Icons.add,
                              size: 14, color: AppConfig.backgroundColor),
                        ),
                      ),
                    ),
                  ],
                ),
                CommonWidgets.horizontalSpace(3),
                GestureDetector(
                  onTap: () {
                    StockHistory.clearStockHistory(data['id'])
                        .then((value) => _getStockData());
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _setProducts() async {
    RestDatasource api = RestDatasource();

    dynamic bodyJson = {
      "van_id": "1",
      "store_id": AppState().storeId,
      "user_id": AppState().userId,
      "item_id": [],
      "quantity": [],
      "unit": []
    };
    for (var item in stocks) {
      bodyJson["item_id"].add(item["id"]);
      bodyJson["quantity"].add(item["quantity"]);
      bodyJson["unit"].add(item["unit"]);
    }
    print('resJson $bodyJson');
    dynamic resJson = await api.sendData(
        '/api/vanrequest.store', AppState().token, jsonEncode(bodyJson));
    if (resJson['data'] != null) {
      if (mounted) {
        CommonWidgets.showDialogueBox(
            context: context, title: "Alert", msg: "Added Successfully");
        StockHistory.clearAllStockHistory().then(
            (value) => Navigator.of(context).pushNamed(HomeScreen.routeName));
      }
    }
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(
        value: "PCS",
        child: Text("PCS"),
      ),
      DropdownMenuItem(
        value: "BOX",
        child: Text("BOX"),
      ),
      DropdownMenuItem(
        value: "Container",
        child: Text("Container"),
      ),
    ];
    return menuItems;
  }
}
