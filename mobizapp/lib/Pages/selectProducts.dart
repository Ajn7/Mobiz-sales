import 'package:flutter/material.dart';
import 'package:mobizapp/Models/appstate.dart';
import 'package:mobizapp/Models/quantitymodel.dart' as Qty;
import 'package:mobizapp/Pages/vanstock.dart';
import 'package:shimmer/shimmer.dart';

import '../Models/ProductsModelClass.dart';
import '../Models/stockData.dart';
import '../Utilities/rest_ds.dart';
import '../confg/appconfig.dart';
import '../confg/sizeconfig.dart';
import '../Components/commonwidgets.dart';

class SelectProductsScreen extends StatefulWidget {
  static const routeName = "/SelectProductScreen";
  const SelectProductsScreen({super.key});

  @override
  State<SelectProductsScreen> createState() => _SelectProductsScreenState();
}

class _SelectProductsScreenState extends State<SelectProductsScreen> {
  final TextEditingController _searchData = TextEditingController();
  ProductsModel products = ProductsModel();
  Qty.QuantityModel qunatityData = Qty.QuantityModel();
  bool _initDone = false;
  List<int> selectedItems = [];
  List<Map<String, dynamic>> items = [];
  bool _search = false;
  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConfig.backgroundColor),
        title: const Text(
          'Van Stocks',
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
              (_initDone)
                  ? SizedBox(
                      height: SizeConfig.blockSizeVertical * 78,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            CommonWidgets.verticalSpace(1),
                        itemCount: products.result!.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            _productsCard(products.result!.data![index], index),
                      ),
                    )
                  : Shimmer.fromColors(
                      baseColor: AppConfig.buttonDeactiveColor.withOpacity(0.1),
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
            int id = data.itemId!;
            removeItem(id);
            selectedItems.remove(index);
          } else {
            selectedItems.add(index);
            addItem(
              data.products![0].name!,
              data.products![0].code!,
              data.itemId!,
              data.quandity!,
            );

            Navigator.pushReplacementNamed(context, VanStocks.routeName);
          }
        });
      },
      child: Card(
        elevation: 3,
        child: Container(
          height: SizeConfig.blockSizeVertical * 8,
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
                      image: const NetworkImage(
                          'https://www.vecteezy.com/vector-art/5337799-icon-image-not-found-vector'),
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
                    Text(
                      data.itemId.toString(),
                      style: TextStyle(
                          fontSize: AppConfig.paragraphSize,
                          fontWeight: AppConfig.headLineWeight),
                    ),
                    Text(
                      (data.products![0].name ?? ''),
                      style: TextStyle(fontSize: AppConfig.textCaption3Size),
                    ),
                    Row(
                      children: [
                        for (int i = 0;
                            i < qunatityData.result!.data!.length;
                            i++)
                          Text(
                            '${qunatityData.result!.data![i].units![0].name}: ${products.result!.data![0].quandity! / qunatityData.result!.data![i].qty!} |',
                            style: TextStyle(
                                fontSize: AppConfig.textCaption3Size,
                                fontWeight: AppConfig.headLineWeight),
                          ),
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
        '/api/get_van_stock?store_id=2&van_id=1',
        AppState().token); //${AppState().storeId}
    if (resJson['status'] == "success") {
      products = ProductsModel.fromJson(resJson);
      _getQuantity();
    }
  }

  Future<void> _getQuantity() async {
    RestDatasource api = RestDatasource();
    dynamic resJson = await api.getDetails(
        '/api/get_van_stock_detail?product_id=${products.result!.data![0].itemId}',
        AppState().token); //${AppState().storeId}
    print('Responsde Details ${resJson}');

    if (resJson['status'] == "success") {
      qunatityData = Qty.QuantityModel.fromJson(resJson);
      setState(
        () {
          _initDone = true;
        },
      );
    }
  }

  void addItem(String name, String code, int id, int quantity) async {
    Map<String, dynamic> newItem = {
      "name": name,
      "code": code,
      "id": id,
      "quantity": quantity
    };

    // Check for duplicates before adding
    bool containsDuplicate = items.any((item) => item['id'] == id);
    if (!containsDuplicate) {
      items.add(newItem);
      await StockHistory.addToStockHistory(newItem);
    }
  }

  // Function to remove an item from the list by id
  void removeItem(int id) {
    items.removeWhere((item) => item['id'] == id);
  }
}
