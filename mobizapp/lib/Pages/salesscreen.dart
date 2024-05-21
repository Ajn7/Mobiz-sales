import 'package:flutter/material.dart';
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
  List<Map<String, dynamic>> stocks = [
    {
      'category': 'CONFECTIONARY',
      'code': '10216',
      'quantity': 2.0,
      'sub': 'CEREALS'
    },
    {
      'category': 'CONFECTIONARY',
      'code': '10216',
      'quantity': 3.0,
      'sub': 'CEREALS'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConfig.backgroundColor),
        title: const Text(
          'New Sales',
          style: TextStyle(color: AppConfig.backgroundColor),
        ),
        backgroundColor: AppConfig.colorPrimary,
        actions: [
          Container(
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
                  hintText: "Select Product...",
                  hintStyle: TextStyle(color: AppConfig.backgroundColor),
                  border: InputBorder.none),
            ),
          ),
          CommonWidgets.horizontalSpace(1),
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.search,
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
            backgroundColor: const MaterialStatePropertyAll(Color(0xff1867ae)),
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
              Text(
                'Your Orders',
                style: TextStyle(
                    fontSize: AppConfig.headLineSize,
                    color: AppConfig.buttonDeactiveColor,
                    fontWeight: AppConfig.headLineWeight),
              ),
              CommonWidgets.verticalSpace(2),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 60,
                child: ListView.separated(
                  itemCount: stocks.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return _stockCard(stocks[index]);
                  },
                  separatorBuilder: (context, index) {
                    return CommonWidgets.verticalSpace(1);
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Sub Total : 244.36',
                      style: TextStyle(fontSize: AppConfig.textCaptionSize),
                    ),
                    Text(
                      'Discount : 0.00',
                      style: TextStyle(fontSize: AppConfig.textCaptionSize),
                    ),
                    Text(
                      'Tax : 12.22',
                      style: TextStyle(fontSize: AppConfig.textCaptionSize),
                    ),
                    Text(
                      'Round Off. : 0.42',
                      style: TextStyle(fontSize: AppConfig.textCaptionSize),
                    ),
                    Text(
                      'Total : 257.00',
                      style: TextStyle(fontSize: AppConfig.textCaptionSize),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _stockCard(Map<dynamic, dynamic> data) {
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(5),
        width: SizeConfig.blockSizeHorizontal * 90,
        height: SizeConfig.blockSizeVertical * 9,
        decoration: const BoxDecoration(
          color: AppConfig.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ListTile(
          leading: SizedBox(
            width: 40,
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
          title: Text(data['code'],
              style: TextStyle(
                  fontSize: AppConfig.textCaption2Size,
                  fontWeight: AppConfig.headLineWeight)),
          subtitle: Text(
            'Category:${data['category']}\nSub Category:${data['sub']}\n',
            style: TextStyle(fontSize: AppConfig.textCaption3Size * 0.9),
          ),
          trailing:
              //Text(data['quantity'].toString()),
              SizedBox(
            width: SizeConfig.blockSizeHorizontal * 21,
            child: Row(
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // StockHistory.clearStockHistory(data['id'])
                        //     .then((value) => _getStockData());
                      },
                      child:
                          const Icon(Icons.edit, color: AppConfig.colorPrimary),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        // StockHistory.clearStockHistory(data['id'])
                        //     .then((value) => _getStockData());
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                CommonWidgets.horizontalSpace(2),
                Text(
                  data['quantity'].toString(),
                  style: const TextStyle(fontSize: 15),
                ),
                CommonWidgets.horizontalSpace(3),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            if (data['quantity'] > 1) {
                              data['quantity'] = data['quantity'] - 1;
                            }
                          },
                        );
                      },
                      child: CircleAvatar(
                        radius: 9,
                        backgroundColor: Colors.red,
                        child: Center(
                          child: Text('-',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppConfig.backgroundColor,
                                  fontWeight: AppConfig.headLineWeight)),
                        ),
                      ),
                    ),
                    CommonWidgets.verticalSpace(2),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          data['quantity'] = data['quantity'] + 1;
                        });
                      },
                      child: const CircleAvatar(
                        radius: 9,
                        backgroundColor: Colors.green,
                        child: Center(
                          child: Icon(Icons.add,
                              size: 14, color: AppConfig.backgroundColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
