import 'package:flutter/material.dart';
import 'package:mobizapp/Models/appstate.dart';
import 'package:mobizapp/Pages/newvanstockrequests.dart';
import 'package:shimmer/shimmer.dart';

import '../Models/ProductDataModelClass.dart';
import '../Models/productquantirydetails.dart' as Qty;
import '../Models/salesdata.dart';
import '../Utilities/rest_ds.dart';
import '../confg/appconfig.dart';
import '../confg/sizeconfig.dart';
import '../Components/commonwidgets.dart';
import 'salesscreen.dart';

class SalesSelectProductsScreen extends StatefulWidget {
  static const routeName = "/SalesSelectProductScreen";
  const SalesSelectProductsScreen({super.key});

  @override
  State<SalesSelectProductsScreen> createState() =>
      _SalesSelectProductsScreenState();
}

class _SalesSelectProductsScreenState extends State<SalesSelectProductsScreen> {
  final TextEditingController _searchData = TextEditingController();
  ProductDataModel products = ProductDataModel();
  bool _initDone = false;
  bool _noData = false;
  List<int> selectedItems = [];
  List<Map<String, dynamic>> items = [];
  bool _search = false;

  int? id;
  String? name;

  Qty.ProductQuantityDetails qunatityData = Qty.ProductQuantityDetails();
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
          'Select Products',
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
                        hintStyle: TextStyle(color: AppConfig.backgroundColor),
                        border: InputBorder.none),
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
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedItems.contains(index)) {
            int id = data.id!;
            removeItem(id);
            selectedItems.remove(index);
          } else {
            selectedItems.add(index);

            addItem(
              data.name!,
              data.code!,
              data.id!,
              data.baseUnitQty!,
              data.baseUnitId!,
              data.price!,
              id!,
              data.taxPercentage!,
              num.parse(data.baseUnitDiscount!),
              data.unitData.result!.data!,
              '', //type
              data.price!,
              data.proImage!,
            );
            Navigator.pushReplacementNamed(context, SalesScreen.routeName,
                arguments: {'customerId': id, 'name': name});
          }
        });
      },
      child: Card(
        elevation: 3,
        child: Container(
          width: SizeConfig.blockSizeHorizontal * 90,
          decoration: BoxDecoration(
            border: Border.all(
                color: selectedItems.contains(index)
                    ? AppConfig.colorPrimary
                    : Colors.transparent),
            color: AppConfig.backgroundColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: FadeInImage(
                      image: NetworkImage(
                          'https://mobiz-shop.yes45.in/uploads/product/${data.proImage}'),
                      placeholder:
                          const AssetImage('Assets/Images/no_image.jpg'),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset('Assets/Images/no_image.jpg',
                            fit: BoxFit.fitWidth);
                      },
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                CommonWidgets.horizontalSpace(3),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Tooltip(
                      message: data.name!.toUpperCase(),
                      child: SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 70,
                        child: Text(
                          data.name!.toUpperCase(),
                          style: TextStyle(fontSize: AppConfig.paragraphSize),
                        ),
                      ),
                    ),
                    Text(
                      data.code.toString(),
                      style: TextStyle(
                          fontSize: AppConfig.textCaption3Size,
                          fontWeight: AppConfig.headLineWeight),
                    ),
                    Row(
                      children: [
                        for (int i = 0;
                            i < data.unitData.result!.data!.length;
                            i++)
                          Text(
                            (i == 0)
                                ? '${data.unitData.result!.data![i].units![0].name!}: ${formatDivisionResult(data.unitData.result!.data![i].qty!, 1, data.unitData.result!.data![i].units![0].name!)}'
                                : (i == 1)
                                    ? '| ${data.unitData.result!.data![i].units![0].name!}: ${formatDivisionResult(data.unitData.result!.data![i].qty!, 1, data.unitData.result!.data![i].units![0].name!)} '
                                    : (i == 2)
                                        ? '| ${data.unitData.result.data![i].units![0].name!}: ${formatDivisionResult(data.unitData.result!.data![i].qty!, 1, data.unitData.result!.data![i].units![0].name!)}'
                                        : '| ${data.unitData.result.data![i].units![0].name!}: ${formatDivisionResult(data.unitData.result!.data![i].qty!, 1, data.unitData.result!.data![i].units![0].name!)}',
                            style: TextStyle(
                                fontSize: AppConfig.textCaption3Size,
                                fontWeight: AppConfig.headLineWeight),
                          )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getProducts() async {
    RestDatasource api = RestDatasource();
    dynamic resJson = await api.getDetails(
        '/api/get_product?store_id=${AppState().storeId}', AppState().token); //

    if (resJson['data'] != null) {
      products = ProductDataModel.fromJson(resJson);
      for (int i = 0; i < products.data!.length; i++) {
        _getQuantity(i, products.data![i].id!);
      }
    } else {
      setState(() {
        _noData = true;
        _initDone = true;
      });
    }
  }

  void addItem(
    String name,
    String code,
    int id,
    int quantity,
    int baseUnit,
    num mrp,
    int cuId,
    num tax,
    num discount,
    List unitData,
    String type,
    num total,
    String image,
  ) async {
    Map<String, dynamic> newItem = {
      "customerId": cuId,
      "name": name,
      "code": code,
      "itemId": id,
      "quantity": quantity,
      "unit": baseUnit,
      "mrp": mrp,
      'discount': discount,
      'total': total,
      'tax': tax,
      'unitData': unitData,
      'type': type,
      'oldmrp': mrp,
      'icode': '$id${DateTime.now()}',
      "image": image
    };

    // Check for duplicates before adding
    bool containsDuplicate = items.any((item) => item['id'] == id);
    if (!containsDuplicate) {
      items.add(newItem);
      await SaleskHistory.addToSalesHistory(newItem);
    }
  }

  // Function to remove an item from the list by id
  void removeItem(int id) {
    items.removeWhere((item) => item['id'] == id);
  }

  Future<void> _getQuantity(int i, int id) async {
    RestDatasource api = RestDatasource();
    dynamic resJson = await api.getDetails(
        '/api/get_product_detail?product_id=$id',
        AppState().token); //${AppState().storeId}

    if (resJson['status'] == "success") {
      qunatityData = Qty.ProductQuantityDetails.fromJson(resJson);
      products.data![i].unitData = qunatityData;
      if (i == products.data!.length - 1) {
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(
              () {
                _initDone = true;
              },
            );
          }
        });
      }
    }
  }

  String formatDivisionResult(int numerator, int denominator, String name) {
    if (denominator == 0) {
      throw ArgumentError("Denominator cannot be zero.");
    }
    print('Datas $numerator, $denominator');
    double result = numerator / denominator;

    result = double.parse(result.toStringAsFixed(1));

    int integerPart = result.floor();
    double fractionalPart = result - integerPart;

    int fractionalPartInPieces = (fractionalPart * 10).round();

    if (fractionalPartInPieces != 0) {
      return (integerPart != 0)
          ? "$integerPart $name $fractionalPartInPieces Piece"
          : "$fractionalPartInPieces Piece";
    } else {
      return "$integerPart";
    }
  }
}
