import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobizapp/Models/appstate.dart';
import 'package:mobizapp/Pages/newvanstockrequests.dart';
import 'package:mobizapp/Pages/salesscreen.dart';
import 'package:shimmer/shimmer.dart';

import '../Models/productquantirydetails.dart' as Qty;
import '../Models/salesdata.dart';
import '../Models/vansaleproduct.dart';
import '../Utilities/rest_ds.dart';
import '../confg/appconfig.dart';
import '../confg/sizeconfig.dart';
import '../Components/commonwidgets.dart';

class SaleInvoiceScrreen extends StatefulWidget {
  static const routeName = "/SalreInvoice";
  const SaleInvoiceScrreen({super.key});

  @override
  State<SaleInvoiceScrreen> createState() => _SaleInvoiceScrreenState();
}

class _SaleInvoiceScrreenState extends State<SaleInvoiceScrreen> {
  final TextEditingController _searchData = TextEditingController();
  VanSaleProducts products = VanSaleProducts();
  bool _initDone = false;
  bool _noData = false;
  List<int> selectedItems = [];
  List<Map<String, dynamic>> items = [];
  bool _search = false;
  int? customerId;

  int? id;
  String? name;

  Qty.ProductQuantityDetails qunatityData = Qty.ProductQuantityDetails();
  List<Qty.ProductQuantityDetails> quantity = [];
  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final Map<String, dynamic>? params =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      id = params!['customerId'];
      name = params!['name'];
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConfig.backgroundColor),
        title: const Text(
          'Sales Invoice',
          style: TextStyle(color: AppConfig.backgroundColor),
        ),
        backgroundColor: AppConfig.colorPrimary,
        actions: [
          // (_search)
          //     ? Container(
          //         height: SizeConfig.blockSizeVertical * 5,
          //         width: SizeConfig.blockSizeHorizontal * 76,
          //         decoration: BoxDecoration(
          //           color: AppConfig.colorPrimary,
          //           borderRadius: const BorderRadius.all(
          //             Radius.circular(10),
          //           ),
          //           border: Border.all(color: AppConfig.colorPrimary),
          //         ),
          //         child: TextField(
          //           controller: _searchData,
          //           decoration: const InputDecoration(
          //               contentPadding: EdgeInsets.all(5),
          //               hintText: "Search...",
          //               hintStyle: TextStyle(color: AppConfig.backgroundColor),
          //               border: InputBorder.none),
          //         ),
          //       )
          //     : Container(),
          // CommonWidgets.horizontalSpace(1),
          // GestureDetector(
          //   onTap: () {
          //     setState(() {
          //       _search = !_search;
          //     });
          //   },
          //   child: Icon(
          //     (!_search) ? Icons.search : Icons.close,
          //     size: 30,
          //     color: AppConfig.backgroundColor,
          //   ),
          // ),
          // CommonWidgets.horizontalSpace(3),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: SizedBox(
      //   width: SizeConfig.blockSizeHorizontal * 25,
      //   height: SizeConfig.blockSizeVertical * 5,
      //   child: ElevatedButton(
      //     style: ButtonStyle(
      //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //         RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(20.0),
      //         ),
      //       ),
      //       backgroundColor:
      //           const MaterialStatePropertyAll(AppConfig.colorPrimary),
      //     ),
      //     onPressed: () async {
      //       for (var item in items) {
      //         await StockHistory.addToStockHistory(item);
      //       }
      //       if (mounted) {
      //         Navigator.of(context).pop();
      //       }
      //     },
      //     child: Text(
      //       'ADD',
      //       style: TextStyle(
      //           fontSize: AppConfig.textCaption3Size,
      //           color: AppConfig.backgroundColor,
      //           fontWeight: AppConfig.headLineWeight),
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CommonWidgets.verticalSpace(1),
              (_initDone && !_noData)
                  ? SizedBox(
                      height: SizeConfig.blockSizeVertical * 78,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            CommonWidgets.verticalSpace(1),
                        itemCount: products.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            _productsCard(products.data![index], index),
                      ),
                    )
                  : (_noData && _initDone)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              CommonWidgets.verticalSpace(3),
                              const Center(
                                child: Text('No Data'),
                              ),
                            ])
                      : Shimmer.fromColors(
                          baseColor:
                              AppConfig.buttonDeactiveColor.withOpacity(0.1),
                          highlightColor: AppConfig.backButtonColor,
                          child: Center(
                            child: Column(
                              children: [
                                CommonWidgets.loadingContainers(
                                    height: SizeConfig.blockSizeVertical * 10,
                                    width: SizeConfig.blockSizeHorizontal * 90),
                                CommonWidgets.loadingContainers(
                                    height: SizeConfig.blockSizeVertical * 10,
                                    width: SizeConfig.blockSizeHorizontal * 90),
                                CommonWidgets.loadingContainers(
                                    height: SizeConfig.blockSizeVertical * 10,
                                    width: SizeConfig.blockSizeHorizontal * 90),
                                CommonWidgets.loadingContainers(
                                    height: SizeConfig.blockSizeVertical * 10,
                                    width: SizeConfig.blockSizeHorizontal * 90),
                                CommonWidgets.loadingContainers(
                                    height: SizeConfig.blockSizeVertical * 10,
                                    width: SizeConfig.blockSizeHorizontal * 90),
                                CommonWidgets.loadingContainers(
                                    height: SizeConfig.blockSizeVertical * 10,
                                    width: SizeConfig.blockSizeHorizontal * 90),
                              ],
                            ),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productsCard(Data data, int index) {
    return Card(
      elevation: 1,
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 90,
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey.withOpacity(0.3)),
          color: AppConfig.backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Tooltip(
                message: data.invoiceNo!,
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 70,
                  child: Text(
                    '${data.invoiceNo!} | ${DateFormat('dd MMMM yyyy').format(DateTime.parse(data.inDate!))} ${data.inTime}',
                    style: TextStyle(fontSize: AppConfig.paragraphSize),
                  ),
                ),
              ),
              Text(
                (data.detail!.isNotEmpty) ? data.detail![0].name ?? '' : '',
                style: TextStyle(
                    fontSize: AppConfig.textCaption3Size,
                    fontWeight: AppConfig.headLineWeight),
              ),
              (data.detail!.isNotEmpty)
                  ? Text('Type: ${data.detail![0].productType}')
                  : const Text('Type:  '),
              Text('Total: ${data.total}'),
              Text('Discount(%): ${data.discount}'),
              Text('Round Off: ${data.roundOff ?? ''}'),
              Text('Grand Total: ${data.grandTotal}'),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getProducts() async {
    RestDatasource api = RestDatasource();
    dynamic resJson = await api.getDetails(
        '/api/vansale.index?store_id=${AppState().storeId}&van_id=${AppState().vanId}',
        AppState().token); //

    if (resJson['data'] != null) {
      products = VanSaleProducts.fromJson(resJson);
      setState(() {
        _initDone = true;
      });
    } else {
      setState(() {
        _noData = true;
        _initDone = true;
      });
    }
  }
}
