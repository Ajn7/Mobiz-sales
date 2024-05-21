import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobizapp/Pages/selectProducts.dart';
import 'package:mobizapp/Pages/vanstock.dart';
import 'package:shimmer/shimmer.dart';

import '../Components/commonwidgets.dart';
import '../Models/appstate.dart';
import '../Models/requestmodelclass.dart';
import '../Utilities/rest_ds.dart';
import '../confg/appconfig.dart';
import '../confg/sizeconfig.dart';

class VanStockRequestsScreen extends StatefulWidget {
  static const routeName = "/vanstockrequests";
  const VanStockRequestsScreen({super.key});

  @override
  State<VanStockRequestsScreen> createState() => _VanStockRequestsScreenState();
}

class _VanStockRequestsScreenState extends State<VanStockRequestsScreen> {
  bool _initDone = false;
  bool _nodata = false;
  RequestModel request = RequestModel();
  final TextEditingController _searchData = TextEditingController();
  bool _search = false;
  @override
  void initState() {
    super.initState();
    _getRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConfig.colorPrimary,
        iconTheme: const IconThemeData(color: AppConfig.backgroundColor),
        title: const Text(
          'Van Stock Requests',
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
          (!_search)
              ? GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, VanStocks.routeName);
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
      body: Padding(
        padding: const EdgeInsets.only(bottom: 18.0, left: 18, right: 18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              (_initDone && !_nodata)
                  ? SizedBox(
                      height: SizeConfig.blockSizeVertical * 85,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            CommonWidgets.verticalSpace(1),
                        itemCount: request.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            _requestsTab(index, request.data![index]),
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

  Widget _requestsTab(int index, Data data) {
    return Card(
      elevation: 3,
      child: Container(
        decoration: const BoxDecoration(
            color: AppConfig.backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          trailing: Transform.rotate(
            angle: 100,
            child: Icon(
              Icons.touch_app,
              color: AppConfig.buttonDeactiveColor.withOpacity(0.7),
            ),
          ),
          backgroundColor: AppConfig.backgroundColor,
          title: Row(
            children: [
              CommonWidgets.horizontalSpace(1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 65,
                    child: Row(
                      children: [
                        Text(
                          'VS0${data.detail![0].vanRequestId}',
                          style:
                              TextStyle(fontWeight: AppConfig.headLineWeight),
                        ),
                        const Spacer(),
                        Text(
                          (data.status == 1)
                              ? 'Pending'
                              : (data.status == 2)
                                  ? 'Approval'
                                  : 'Confirmed',
                          style: TextStyle(
                              fontSize: AppConfig.textCaption3Size,
                              color: (data.status == 1)
                                  ? AppConfig.colorWarning
                                  : (data.status == 2)
                                      ? Colors.orange
                                      : Colors.green,
                              fontWeight: AppConfig.headLineWeight),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    data.inDate!.substring(0, 10),
                    style: TextStyle(
                        fontSize: AppConfig.textCaption3Size * 0.9,
                        fontWeight: AppConfig.headLineWeight),
                  ),
                ],
              ),
            ],
          ),
          children: <Widget>[
            (data.status != 3)
                ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidgets.verticalSpace(1),
                        const Divider(
                          color: AppConfig.textBlack,
                        ),
                        for (int i = 0; i < data.detail!.length; i++)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.detail![i].id.toString(),
                                style: TextStyle(
                                    fontSize: AppConfig.textCaption3Size,
                                    fontWeight: AppConfig.headLineWeight),
                              ),
                              Row(
                                children: [
                                  Text(
                                    (data.detail![i].productName ?? '')
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontSize: AppConfig.textCaption3Size,
                                        fontWeight: AppConfig.headLineWeight),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'PCS QTY : ${data.detail![i].approvedQuantity}',
                                    style: TextStyle(
                                        fontSize: AppConfig.textCaption3Size,
                                        fontWeight: AppConfig.headLineWeight),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: AppConfig.textBlack,
                              ),
                            ],
                          ),
                        // Text(
                        //   'RB0002',
                        //   style: TextStyle(
                        //       fontSize: AppConfig.textCaption3Size,
                        //       fontWeight: AppConfig.headLineWeight),
                        // ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       'KELLOGGS KORN FLAKE',
                        //       style: TextStyle(
                        //           fontSize: AppConfig.textCaption3Size,
                        //           fontWeight: AppConfig.headLineWeight),
                        //     ),
                        //     const Spacer(),
                        //     Text(
                        //       'BOX QTY : 10',
                        //       style: TextStyle(
                        //           fontSize: AppConfig.textCaption3Size,
                        //           fontWeight: AppConfig.headLineWeight),
                        //     ),
                        //   ],
                        // ),
                        // const Divider(),
                        // CommonWidgets.verticalSpace(2),
                        Center(
                          child: SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 25,
                            height: SizeConfig.blockSizeVertical * 5,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                backgroundColor: const MaterialStatePropertyAll(
                                    AppConfig.colorPrimary),
                              ),
                              onPressed: () {
                                _conformrequest(data.id!);
                              },
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                    fontSize: AppConfig.textCaption3Size,
                                    color: AppConfig.backgroundColor,
                                    fontWeight: AppConfig.headLineWeight),
                              ),
                            ),
                          ),
                        ),
                        CommonWidgets.verticalSpace(2),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidgets.verticalSpace(1),
                        const Divider(
                          color: AppConfig.textBlack,
                        ),
                        for (int i = 0; i < data.detail!.length; i++)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.detail![i].id.toString(),
                                style: TextStyle(
                                    fontSize: AppConfig.textCaption3Size,
                                    fontWeight: AppConfig.headLineWeight),
                              ),
                              Row(
                                children: [
                                  Text(
                                    (data.detail![i].productName ?? '')
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontSize: AppConfig.textCaption3Size,
                                        fontWeight: AppConfig.headLineWeight),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'PCS QTY : ${data.detail![i].approvedQuantity}',
                                    style: TextStyle(
                                        fontSize: AppConfig.textCaption3Size,
                                        fontWeight: AppConfig.headLineWeight),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: AppConfig.textBlack,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
            // for (int i = 0; i < 2; i++)
            //   ListTile(
            //     visualDensity: VisualDensity.compact,
            //     subtitle: Divider(),
            //     title: Row(
            //       children: [
            //         Column(
            //           children: [
            //             Text(
            //               'Code:${data.c}',
            //               style: TextStyle(
            //                   color: AppConfig.backgroundColor,
            //                   fontSize: AppConfig.textCaption2Size),
            //             ),
            //           ],
            //         ),
            //         const Spacer(),
            //         Text(
            //           'Qty:100',
            //           style: TextStyle(
            //               color: AppConfig.backgroundColor,
            //               fontSize: AppConfig.textCaption3Size),
            //         )
            //       ],
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }

  Future<void> _getRequests() async {
    RestDatasource api = RestDatasource();
    dynamic resJson = await api.getDetails(
        '/api/vanrequest.index?store_id=${AppState().storeId}&van_id=1',
        AppState().token);

    if (resJson['data'] != null) {
      request = RequestModel.fromJson(resJson);
      setState(
        () {
          _initDone = true;
        },
      );
    } else {
      setState(() {
        _initDone = true;
        _nodata = true;
      });
    }
  }

  Future<void> _conformrequest(int id) async {
    RestDatasource api = RestDatasource();

    dynamic bodyJson = {
      "id": id,
    };

    dynamic resJson = await api.sendData(
        '/api/vanrequest.confirm', AppState().token, jsonEncode(bodyJson));
    if (resJson['data'] != null) {
      if (mounted) {
        CommonWidgets.showDialogueBox(
            context: context,
            title: "Alert",
            msg: "Requset Added Successfully");
        setState(() {
          _initDone = false;
        });
        _getRequests();
      }
    }
  }
}
