import 'package:flutter/material.dart';
import 'package:mobizapp/Pages/customerdetailscreen.dart';
import 'package:mobizapp/Pages/customerscreen.dart';
import 'package:mobizapp/Pages/homepage.dart';
import 'package:mobizapp/Pages/loginpage.dart';
import 'package:mobizapp/Pages/productspage.dart';
import 'package:mobizapp/Pages/salesscreen.dart';
import 'package:mobizapp/Pages/selectProducts.dart';
import 'package:mobizapp/Pages/splashscreen.dart';
import 'package:mobizapp/Pages/newvanstockrequests.dart';
import 'package:mobizapp/Pages/vanstockdata.dart';
import 'package:mobizapp/Pages/vanstockrequest.dart';

import 'Pages/saleinvoices.dart';
import 'Pages/salesselectproducts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        initialRoute: SplashScreen.routeName,
        routes: {
          // '/': (context) => Home(),
          LoginScreen.routeName: (context) => LoginScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          ProductsScreen.routeName: (context) => ProductsScreen(),
          VanStockRequestsScreen.routeName: (context) =>
              VanStockRequestsScreen(),
          VanStocks.routeName: (context) => VanStocks(),
          SplashScreen.routeName: (context) => SplashScreen(),
          SelectProductsScreen.routeName: (context) => SelectProductsScreen(),
          CustomersDataScreen.routeName: (context) => CustomersDataScreen(),
          SalesScreen.routeName: (context) => SalesScreen(),
          VanStockScreen.routeName: (context) => VanStockScreen(),
          CustomerDetailsScreen.routeName: (context) => const CustomerDetailsScreen(),
          SalesSelectProductsScreen.routeName: (context) =>
              SalesSelectProductsScreen(),
          SaleInvoiceScrreen.routeName: (context) => const SaleInvoiceScrreen()
        });
  }
}
