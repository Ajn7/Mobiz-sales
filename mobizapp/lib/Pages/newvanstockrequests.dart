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
  static const routeName = "/NewVanStockRequests";
  const VanStocks({super.key});

  @override
  State<VanStocks> createState() => _VanStocksState();
}

class _VanStocksState extends State<VanStocks> {
  final TextEditingController _searchData = TextEditingController();
  bool _initDone = false;
  List<Map<String, dynamic>> stocks = [];
  bool _search = false;
  List<String?> selectedValue = [" ", " "];
  List<List<DropdownMenuItem<String>>> menuItems = [[]];
  List<Map<String, dynamic>?> selectedId = [];
  bool created = false;
  bool _loaded = true;

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
              onPressed: (_loaded == false)
                  ? null
                  : () {
                      if (stocks.isNotEmpty) {
                        setState(() {
                          _loaded = false;
                        });
                        _sendProducts();
                      }
                    },
              child: (_loaded == false)
                  ? const CircularProgressIndicator(
                      color: AppConfig.backgroundColor,
                    )
                  : Text(
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
                              return _stockCard(stocks[index], index);
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
    print('stock Data $stocks');
    menuItems = List.generate(stocks.length, (_) => []);
    selectedValue = List.filled(stocks.length, '');
    selectedId = List.filled(stocks.length, {});
    for (int index = 0; index < stocks.length; index++) {
      dynamic listData = stocks[index]['unitData'].toSet().toList();
      for (int i = 0; i < listData.length; i++) {
        menuItems[index].add(DropdownMenuItem(
            value: (listData[i]['units'][0]['name']).toString(),
            child: Text((listData[i]['units'][0]['name']).toString())));
        selectedValue[index] = (stocks[index]['selectedUnit'] != null)
            ? stocks[index]['selectedUnit']
            : listData[i]['units'][0]['name'].toString();
        selectedId[index] = {
          'name': listData[i]['units'][0]['name'].toString(),
          'id': listData[i]['units'][0]['id'],
        };
      }
    }

    setState(() {
      _initDone = true;
    });
  }

  Widget _stockCard(Map<dynamic, dynamic> data, int index) {
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(5),
        width: SizeConfig.blockSizeHorizontal * 90,
        decoration: const BoxDecoration(
          color: AppConfig.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ListTile(
          title: Tooltip(
            message: data['name'].toString().toUpperCase(),
            child: Text(data['name'].toString().toUpperCase(),
                style: TextStyle(fontSize: AppConfig.textCaption2Size)),
          ),
          subtitle: Text(
            data['code'],
            style: TextStyle(fontSize: AppConfig.textCaption3Size),
          ),
          trailing:
              //Text(data['quantity'].toString()),
              SizedBox(
            width: SizeConfig.blockSizeHorizontal * 45,
            child: Row(
              children: [
                const Spacer(),
                DropdownButton(
                    value: selectedValue[index],
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue[index] = newValue!;
                      });
                      StockHistory.updateStockItem(
                          data['id'], 'selectedUnit', selectedValue[index]);
                    },
                    items: menuItems[index]),
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
                        StockHistory.updateStockItem(
                            data['id'], 'quantity', data['quantity']);
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
                        StockHistory.updateStockItem(
                            data['id'], 'quantity', data['quantity']);
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

  Future<void> _sendProducts() async {
    RestDatasource api = RestDatasource();
    dynamic bodyJson = {
      "van_id": AppState().vanId,
      "store_id": AppState().storeId,
      "user_id": AppState().userId,
      "item_id": [],
      "quantity": [],
      "unit": []
    };
    int units = 0;
    for (int i = 0; i < stocks.length; i++) {
      for (var j in stocks[i]['unitData']) {
        if (j['units'][0]['name'] == selectedValue[i]) {
          units = j['units'][0]['id'];
        }
      }
      //stocks
      bodyJson["item_id"].add(stocks[i]["id"]);
      bodyJson["quantity"].add(stocks[i]["quantity"]);
      bodyJson["unit"].add(units);
    }
    debugPrint('resJson $bodyJson ');
    dynamic resJson = await api.sendData(
        '/api/vanrequest.store', AppState().token, jsonEncode(bodyJson));
    setState(() {
      _loaded = true;
    });
    if (resJson['data'] != null) {
      if (mounted) {
        CommonWidgets.showDialogueBox(
            context: context, title: "Alert", msg: "Added Successfully");
        StockHistory.clearAllStockHistory().then(
            (value) => Navigator.of(context).pushNamed(HomeScreen.routeName));
      }
    }
  }
}
