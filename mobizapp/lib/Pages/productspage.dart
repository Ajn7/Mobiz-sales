import 'package:flutter/material.dart';
import 'package:mobizapp/Models/appstate.dart';
import 'package:shimmer/shimmer.dart';

import '../Models/ProductDataModelClass.dart';
import '../Utilities/rest_ds.dart';
import '../confg/appconfig.dart';
import '../confg/sizeconfig.dart';
import '../Components/commonwidgets.dart';

class ProductsScreen extends StatefulWidget {
  static const routeName = "/ProductScreen";
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController _searchData = TextEditingController();
  ProductDataModel products = ProductDataModel();
  bool _initDone = false;
  bool _nodata = false;
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
        backgroundColor: AppConfig.colorPrimary,
        iconTheme: const IconThemeData(color: AppConfig.backgroundColor),
        title: const Text(
          'Products',
          style: TextStyle(color: AppConfig.backgroundColor),
        ),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CommonWidgets.verticalSpace(1),
              (_initDone && !_nodata)
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
                  : (_nodata && _initDone)
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
      elevation: 3,
      child: Container(
        height: SizeConfig.blockSizeVertical * 8,
        width: SizeConfig.blockSizeHorizontal * 90,
        decoration: const BoxDecoration(
          color: AppConfig.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                    placeholder: const AssetImage('Assets/Images/no_image.jpg'),
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
                    data.id.toString(),
                    style: TextStyle(
                        fontSize: AppConfig.paragraphSize,
                        fontWeight: AppConfig.headLineWeight),
                  ),
                  Text(
                    data.name!,
                    style: TextStyle(fontSize: AppConfig.textCaption3Size),
                  ),
                  Row(
                    children: [
                      Text(
                        'PCS: 10 |',
                        style: TextStyle(
                            fontSize: AppConfig.textCaption3Size,
                            fontWeight: AppConfig.headLineWeight),
                      ),
                      Text(
                        'Box: 10 |',
                        style: TextStyle(
                            fontSize: AppConfig.textCaption3Size,
                            fontWeight: AppConfig.headLineWeight),
                      ),
                      Text(
                        'Container: 30',
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
    );
  }

  Future<void> _getProducts() async {
    RestDatasource api = RestDatasource();
    dynamic resJson = await api.getDetails(
        '/api/get_product?store_id=${AppState().storeId}', AppState().token);

    if (resJson['data'] != null) {
      products = ProductDataModel.fromJson(resJson);
      setState(() {
        _initDone = true;
      });
    } else {
      setState(() {
        _initDone = true;
        _nodata = true;
      });
    }
  }
}
