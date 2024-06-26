import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobizapp/Components/commonwidgets.dart';
import 'package:mobizapp/Pages/customerscreen.dart';
import 'package:mobizapp/Pages/loginpage.dart';
import 'package:mobizapp/Pages/productspage.dart';
import 'package:mobizapp/Pages/receiptscreen.dart';
import 'package:mobizapp/Pages/selectProducts.dart';
import 'package:mobizapp/Pages/newvanstockrequests.dart';
import 'package:mobizapp/Pages/vanstockdata.dart';
import 'package:mobizapp/Pages/vanstockrequest.dart';
import 'package:mobizapp/Utilities/rest_ds.dart';
import 'package:mobizapp/Utilities/sharepref.dart';
import 'package:mobizapp/confg/appconfig.dart';
import 'package:mobizapp/confg/sizeconfig.dart';

import '../Models/appstate.dart';
import '../Models/userDetails.dart';
import 'saleinvoices.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _restrict = false;
  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          centerTitle: false,
          iconTheme: const IconThemeData(color: AppConfig.backgroundColor),
          backgroundColor: AppConfig.colorPrimary,
          titleSpacing: 0,
          title: RichText(
            text: TextSpan(
              text: 'Hello ',
              style: TextStyle(
                  color: AppConfig.backgroundColor,
                  fontSize: AppConfig.textSubtitle3Size),
              children: <TextSpan>[
                TextSpan(
                  text: '${AppState().name}',
                  style: TextStyle(
                      color: AppConfig.backgroundColor,
                      fontSize: AppConfig.textSubtitle3Size),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: SizedBox(
        width: SizeConfig.blockSizeHorizontal * 50,
        child: Drawer(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              children: [
                CommonWidgets.verticalSpace(8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      CommonWidgets.horizontalSpace(3),
                      CircleAvatar(
                        radius: 35.0,
                        backgroundColor: Colors.transparent,
                        child: Image.asset(
                          'Assets/Images/profile.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('Edit Profile'),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Contact Us'),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Printer'),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Log Out'),
                  onTap: () {
                    conformation(context);
                  },
                ),
                const Divider(),
                const Text('v0.0.11'),
              ],
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: SizeConfig.screenHeight,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'Assets/Images/logo.jpg',
                            fit: BoxFit.contain,
                            width: SizeConfig.blockSizeHorizontal * 20,
                            height: SizeConfig.blockSizeVertical * 10,
                          ),
                        ]),
                  ),
                  CommonWidgets.verticalSpace(5),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (_restrict) {
                              CommonWidgets.showDialogueBox(
                                  context: context,
                                  title: "Alert",
                                  msg: "Van not allocated to this user");
                            } else {
                              Navigator.pushNamed(
                                  context, VanStockScreen.routeName);
                            }
                          },
                          child: _iconButtons(
                              icon: Icons.directions_bus, title: 'Van Stock'),
                        ),
                        GestureDetector(
                            onTap: () {
                              if (_restrict) {
                                CommonWidgets.showDialogueBox(
                                    context: context,
                                    title: "Alert",
                                    msg: "Van not allocated to this user");
                              } else {
                                Navigator.pushNamed(
                                    context, CustomersDataScreen.routeName);
                              }
                            },
                            child: _iconButtons(
                                icon: Icons.people, title: 'Customer')),
                        GestureDetector(
                          onTap: () {
                            if (_restrict) {
                              CommonWidgets.showDialogueBox(
                                  context: context,
                                  title: "Alert",
                                  msg: "Van not allocated to this user");
                            } else {
                              Navigator.pushNamed(
                                  context, ProductsScreen.routeName);
                            }
                          },
                          child: _iconButtons(
                              icon: Icons.shopping_cart, title: 'Product'),
                        )
                      ]),
                  CommonWidgets.verticalSpace(3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _iconButtons(icon: Icons.menu_book, title: 'Expense'),
                      _iconButtons(icon: Icons.local_mall, title: 'Order'),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, SaleInvoiceScrreen.routeName),
                        child: _iconButtons(
                            icon: Icons.document_scanner, title: 'Invoice'),
                      )
                    ],
                  ),
                  CommonWidgets.verticalSpace(3),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, ReceiptScreen.receiptScreen),
                          child: _iconButtons(
                              icon: Icons.receipt, title: 'Receipt'),
                        ),
                        _iconButtons(icon: Icons.inventory, title: 'Return'),
                        _iconButtons(
                            icon: Icons.calendar_today, title: 'Schedule'),
                      ]),
                  CommonWidgets.verticalSpace(3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _iconButtons(icon: Icons.groups, title: 'Attendence'),
                      GestureDetector(
                        onTap: () {
                          if (_restrict) {
                            CommonWidgets.showDialogueBox(
                                context: context,
                                title: "Alert",
                                msg: "Van not allocated to this user");
                          } else {
                            Navigator.of(context)
                                .pushNamed(VanStockRequestsScreen.routeName);
                          }
                        },
                        child: _iconButtons(
                            icon: Icons.question_answer,
                            title: 'Van Stock Request'),
                      ),
                      _iconButtons(
                        icon: Icons.receipt_long,
                        title: 'Off Load Request',
                      )
                    ],
                  ),
                  CommonWidgets.verticalSpace(2),
                ],
              ),
            ),
            // Container(
            //   height: SizeConfig.blockSizeVertical * 32.5,
            //   width: SizeConfig.screenWidth,
            //   decoration: BoxDecoration(
            //     color: AppConfig.colorPrimary,
            //     borderRadius: BorderRadius.only(
            //       bottomLeft: const Radius.circular(0),
            //       bottomRight: const Radius.circular(0),
            //       topRight: Radius.elliptical(
            //         MediaQuery.of(context).size.width,
            //         60.0,
            //       ),
            //       topLeft: Radius.elliptical(
            //         MediaQuery.of(context).size.width,
            //         60.0,
            //       ),
            //     ),
            //   ),
            //   child: Column(
            //     children: [
            //       CommonWidgets.verticalSpace(3),
            //       Stack(
            //         clipBehavior: Clip.none,
            //         children: [
            //           Text(
            //             'Mobiz',
            //             style: TextStyle(
            //                 fontSize: AppConfig.headLineSize * 2,
            //                 color: AppConfig.backgroundColor,
            //                 fontWeight: AppConfig.headLineWeight),
            //           ),
            //           Positioned(
            //             top: SizeConfig.blockSizeVertical * 5,
            //             left: 18,
            //             child: Text(
            //               'Sales',
            //               style: TextStyle(
            //                 fontSize: AppConfig.headLineSize * 1.5,
            //                 color: AppConfig.backgroundColor,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //       CommonWidgets.verticalSpace(3),
            //       Image.asset(
            //         'Assets/Images/logo.png',
            //         fit: BoxFit.contain,
            //         width: SizeConfig.blockSizeHorizontal * 30,
            //         height: SizeConfig.blockSizeVertical * 20,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _iconButtons({required IconData icon, required String title}) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 25,
      height: SizeConfig.blockSizeVertical * 12.5,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: AppConfig.colorPrimary),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppConfig.backgroundColor,
            size: 40,
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 18,
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppConfig.backgroundColor,
                    fontSize: AppConfig.textCaption3Size),
              ),
            ),
          )
        ],
      ),
    );
  }

  conformation(BuildContext context) {
    Widget confirmButtons = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: SizeConfig.safeBlockHorizontal! * 30,
            height: SizeConfig.safeBlockVertical! * 5,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                color: AppConfig.colorSuccess),
            child: Center(
              child: Text(
                'CANCEL',
                style: TextStyle(
                    fontFamily: 'helvetica',
                    letterSpacing: 1,
                    fontSize: AppConfig.captionSize,
                    color: AppConfig.backButtonColor),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            SharedPref().clear();
            AppState().loginState = "";
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          },
          child: Container(
            width: SizeConfig.safeBlockHorizontal! * 30,
            height: SizeConfig.safeBlockVertical! * 5,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                color: AppConfig.colorPrimary),
            child: Center(
              child: Text(
                'LOG OUT',
                style: TextStyle(
                    fontFamily: 'helvetica',
                    letterSpacing: 1,
                    fontSize: AppConfig.captionSize,
                    color: AppConfig.backgroundColor),
              ),
            ),
          ),
        ),
      ],
    );
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonWidgets.verticalSpace(2),
            Text(
              "Confirm",
              style: TextStyle(
                  fontSize: AppConfig.headLineSize, fontFamily: 'helvetica'),
            ),
            CommonWidgets.verticalSpace(2),
            Text(
              "Are you sure you want to Logout?",
              style: TextStyle(fontSize: AppConfig.captionSize * 1.2),
              textAlign: TextAlign.center,
            ),
            CommonWidgets.verticalSpace(2),
            confirmButtons,
            CommonWidgets.verticalSpace(2),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> _getUserDetails() async {
    RestDatasource api = RestDatasource();
    UserDetailsModel userData = UserDetailsModel();
    String subUrl = "/api/get_user_detail?user_id=${AppState().userId}";
    dynamic resJson = await api.getDetails(subUrl, AppState().token);
    if (resJson['data'] != null) {
      userData = UserDetailsModel.fromJson(resJson);
      AppState().vanId = userData.data![0].vanId;
      AppState().routeId = userData.data![0].routeId;
    } else {
      if (mounted) {
        _restrict = true;
        CommonWidgets.showDialogueBox(
            context: context,
            title: "Alert",
            msg: "Van not allocated to this user");
      }
    }
  }
}
