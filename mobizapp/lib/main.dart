import 'package:flutter/material.dart';
import 'package:mobizapp/Pages/customerdetailscreen.dart';
import 'package:mobizapp/Pages/customerregistration.dart';
import 'package:mobizapp/Pages/customerscreen.dart';
import 'package:mobizapp/Pages/homepage.dart';
import 'package:mobizapp/Pages/loginpage.dart';
import 'package:mobizapp/Pages/paymentcollection.dart';
import 'package:mobizapp/Pages/productspage.dart';
import 'package:mobizapp/Pages/receiptscreen.dart';
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
          LoginScreen.routeName: (context) => const LoginScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          ProductsScreen.routeName: (context) => const ProductsScreen(),
          VanStockRequestsScreen.routeName: (context) =>
              const VanStockRequestsScreen(),
          VanStocks.routeName: (context) => const VanStocks(),
          SplashScreen.routeName: (context) => const SplashScreen(),
          SelectProductsScreen.routeName: (context) =>
              const SelectProductsScreen(),
          CustomersDataScreen.routeName: (context) =>
              const CustomersDataScreen(),
          SalesScreen.routeName: (context) => const SalesScreen(),
          VanStockScreen.routeName: (context) => const VanStockScreen(),
          CustomerDetailsScreen.routeName: (context) =>
              const CustomerDetailsScreen(),
          SalesSelectProductsScreen.routeName: (context) =>
              const SalesSelectProductsScreen(),
          SaleInvoiceScrreen.routeName: (context) => const SaleInvoiceScrreen(),
          PaymentCollectionScreen.routeName: (context) =>
              const PaymentCollectionScreen(),
          CustomerRegistration.routeName: (context) =>
              const CustomerRegistration(),
          ReceiptScreen.receiptScreen: (context) => const ReceiptScreen(),
        });
  }
}
