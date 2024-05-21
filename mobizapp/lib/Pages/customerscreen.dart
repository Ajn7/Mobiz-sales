import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobizapp/Pages/salesscreen.dart';
import 'package:mobizapp/confg/appconfig.dart';

import '../Components/commonwidgets.dart';
import '../confg/sizeconfig.dart';

class CustomersDataScreen extends StatefulWidget {
  static const routeName = "/CustomersScreen";
  const CustomersDataScreen({super.key});

  @override
  State<CustomersDataScreen> createState() => _CustomersDataScreenState();
}

class _CustomersDataScreenState extends State<CustomersDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConfig.colorPrimary,
        iconTheme: const IconThemeData(color: AppConfig.backButtonColor),
        title: const Text(
          'Shops',
          style: TextStyle(color: AppConfig.backButtonColor),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.add,
              size: 30,
              color: AppConfig.backgroundColor,
            ),
          ),
          CommonWidgets.horizontalSpace(3),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 78,
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    CommonWidgets.verticalSpace(1),
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (context, index) => _customersCard(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _customersCard() {
    return Card(
      elevation: 3,
      child: Container(
        height: SizeConfig.blockSizeVertical * 12,
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
                    'AR101/AL MADINA Jabel Ali',
                    style: TextStyle(
                        fontSize: AppConfig.paragraphSize,
                        fontWeight: AppConfig.headLineWeight),
                  ),
                  Text(
                    'Contact:+971564654',
                    style: TextStyle(fontSize: AppConfig.textCaption3Size),
                  ),
                  Text(
                    'Email:test@gmail.com',
                    style: TextStyle(fontSize: AppConfig.textCaption3Size),
                  ),
                  CommonWidgets.verticalSpace(1),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed(SalesScreen.routeName),
                        child: Container(
                          width: SizeConfig.blockSizeHorizontal * 20,
                          height: SizeConfig.blockSizeVertical * 2.5,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Color(0xff1867ae), Color(0xff045293)],
                            ),
                            //color: Color(0xff1867ae), //Color(0xff045293)
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Sale',
                              style:
                                  TextStyle(color: AppConfig.backgroundColor),
                            ),
                          ),
                        ),
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
}
