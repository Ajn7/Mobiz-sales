import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobizapp/Models/salesdata.dart';
import 'package:mobizapp/Pages/salesselectproducts.dart';
import 'package:mobizapp/confg/appconfig.dart';

import '../Components/commonwidgets.dart';
import '../confg/sizeconfig.dart';

class SalesScreen extends StatefulWidget {
  static const routeName = "/ScalesScreen";
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final TextEditingController _searchData = TextEditingController();
  bool _search = false;
  bool _initDone = false;
  List<Map<String, dynamic>> stocks = [];
  num? subTotal;
  num? discount;
  num? total;
  num? tax;

  List<String?> selectedValue = [" ", " "];
  List<List<DropdownMenuItem<String>>> menuItems = [[]];
  List<Map<String, dynamic>?> selectedId = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getStockData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SaleskHistory.clearAllSalesHistory();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppConfig.backgroundColor),
          title: const Text(
            'Sales',
            style: TextStyle(color: AppConfig.backgroundColor),
          ),
          backgroundColor: AppConfig.colorPrimary,
          actions: [
            (_search)
                ? Container(
                    height: SizeConfig.blockSizeVertical * 5,
                    width: SizeConfig.blockSizeHorizontal * 76,
                    decoration: BoxDecoration(
                      color: AppConfig.colorPrimary,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(color: AppConfig.colorPrimary),
                    ),
                    child: TextField(
                      controller: _searchData,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          hintText: "Search...",
                          hintStyle:
                              TextStyle(color: AppConfig.backgroundColor),
                          border: InputBorder.none),
                    ),
                  )
                : Container(),
            CommonWidgets.horizontalSpace(1),
            (!_search)
                ? GestureDetector(
                    onTap: () async {
                      if (mounted) {
                        Navigator.pushReplacementNamed(
                                context, SalesSelectProductsScreen.routeName)
                            .then((value) {
                          _initDone = false;
                          _getStockData();
                        });
                      }
                    },
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: AppConfig.backgroundColor,
                    ),
                  )
                : Container(),
            CommonWidgets.horizontalSpace(1),
            GestureDetector(
              onTap: () {
                setState(() {
                  _search = !_search;
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: SizeConfig.blockSizeHorizontal * 35,
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
            onPressed: () async {},
            child: Text(
              'SAVE',
              style: TextStyle(
                  fontSize: AppConfig.textCaption3Size,
                  color: AppConfig.backgroundColor,
                  fontWeight: AppConfig.headLineWeight),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                        fontSize: AppConfig.headLineSize,
                        color: AppConfig.buttonDeactiveColor,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: AppConfig.colorPrimary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3))),
                      width: SizeConfig.blockSizeHorizontal * 13,
                      height: SizeConfig.blockSizeVertical * 3,
                      child: const Center(
                          child: Text(
                        'VAT',
                        style: TextStyle(color: AppConfig.backButtonColor),
                      )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3))),
                      width: SizeConfig.blockSizeHorizontal * 13,
                      height: SizeConfig.blockSizeVertical * 3,
                      child: const Center(child: Text('NO VAT')),
                    ),
                  ],
                ),
                CommonWidgets.verticalSpace(1),
                (_initDone)
                    ? SizedBox(
                        height: SizeConfig.blockSizeVertical * 60,
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
                (_initDone && stocks.isNotEmpty)
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Discount ',
                                  style: TextStyle(
                                      fontSize: AppConfig.headLineSize),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: AppConfig.colorPrimary,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(3))),
                                  width: SizeConfig.blockSizeHorizontal * 24,
                                  height: SizeConfig.blockSizeVertical * 3,
                                  child: const Center(
                                      child: Text(
                                    'AMOUNT',
                                    style: TextStyle(
                                        color: AppConfig.backButtonColor),
                                  )),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      // color: AppConfig.colorPrimary,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(3))),
                                  width: SizeConfig.blockSizeHorizontal * 24,
                                  height: SizeConfig.blockSizeVertical * 3,
                                  child: const Center(
                                      child: Text(
                                    'PERCENTAGE',
                                    style:
                                        TextStyle(color: AppConfig.textBlack),
                                  )),
                                ),
                                CommonWidgets.horizontalSpace(2),
                                _dataContainer(data: '$subTotal'),
                              ],
                            ),
                            Text(
                              'Total : $discount',
                              style: TextStyle(
                                  fontSize: AppConfig.textCaptionSize),
                            ),
                            Text(
                              'Vat : $tax',
                              style: TextStyle(
                                  fontSize: AppConfig.textCaptionSize),
                            ),
                            Text(
                              'Round Off. : 0.00',
                              style: TextStyle(
                                  fontSize: AppConfig.textCaptionSize),
                            ),
                            Text(
                              'Grand Total : $total',
                              style: TextStyle(
                                  fontSize: AppConfig.textCaptionSize),
                            ),
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
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
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 50,
                  height: 60,
                  child: FadeInImage(
                    image: const NetworkImage(
                        'https://www.vecteezy.com/vector-art/5337799-icon-image-not-found-vector'),
                    placeholder: const AssetImage('Assets/Images/no_image.jpg'),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset('Assets/Images/no_image.jpg',
                          fit: BoxFit.fitWidth);
                    },
                    fit: BoxFit.fitWidth,
                  ),
                ),
                CommonWidgets.horizontalSpace(1),
                Text(data['code'],
                    style: TextStyle(
                      fontSize: AppConfig.textCaption2Size,
                    )),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 60,
                  child: Text(' | ${data['name'].toString().toUpperCase()}',
                      style: TextStyle(
                        fontSize: AppConfig.textCaption2Size,
                      )),
                ),
              ],
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 90,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Text(
                      'Type',
                      style:
                          TextStyle(color: Color.fromARGB(255, 111, 110, 110)),
                    ),
                    CommonWidgets.horizontalSpace(0.5),
                    _dataContainer(data: ''),
                    CommonWidgets.horizontalSpace(1),
                    const Text(
                      'Unit',
                      style:
                          TextStyle(color: Color.fromARGB(255, 111, 110, 110)),
                    ),
                    CommonWidgets.horizontalSpace(0.5),
                    _dataContainer(data: ''),
                    CommonWidgets.horizontalSpace(1),
                    const Text(
                      'Qty',
                      style:
                          TextStyle(color: Color.fromARGB(255, 111, 110, 110)),
                    ),
                    CommonWidgets.horizontalSpace(0.5),
                    _dataContainer(data: data['quantity'].toString()),
                    CommonWidgets.horizontalSpace(1),
                    const Text(
                      'Rate',
                      style:
                          TextStyle(color: Color.fromARGB(255, 111, 110, 110)),
                    ),
                    CommonWidgets.horizontalSpace(0.5),
                    _dataContainer(data: ''),
                    // DropdownButton(
                    //     value: selectedValue[index],
                    //     onChanged: (String? newValue) {
                    //       setState(() {
                    //         selectedValue[index] = newValue!;
                    //       });
                    //     },
                    //     items: menuItems[index]),
                    CommonWidgets.horizontalSpace(2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getStockData() async {
    stocks = await SaleskHistory.getSalesHistory();
    print('Sales data $stocks');
    menuItems = List.generate(stocks.length, (_) => []);
    selectedValue = List.filled(stocks.length, '');
    selectedId = List.filled(stocks.length, {});
    for (int i = 0; i < stocks.length; i++) {
      for (var j in stocks[i]['unitData']) {
        menuItems[i]
            .add(DropdownMenuItem(value: (j).toString(), child: Text('$j')));
        selectedValue[i] = j;
        selectedId[i] = {
          'name': j,
          //'id': listData[i]['units'][0]['id'],
        };
      }
      subTotal = subTotal ?? 0 + stocks[i]['total'];
      discount = discount ?? 0 + stocks[i]['discount'];
      tax = tax ?? 0 + stocks[i]['tax'];
      total = total ?? 0 + subTotal! + discount! + tax!;
    }

    if (mounted) {
      setState(() {
        _initDone = true;
      });
    }
  }

  _dataContainer({required String data}) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 15,
      decoration: BoxDecoration(
          border: Border.all(color: AppConfig.buttonDeactiveColor),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: Text(
          data,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
