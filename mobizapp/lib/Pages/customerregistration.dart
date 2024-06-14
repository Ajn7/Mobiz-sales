import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobizapp/Components/commonwidgets.dart';
import 'package:mobizapp/Models/appstate.dart';
import 'package:mobizapp/Pages/customerscreen.dart';
import 'package:mobizapp/Pages/homepage.dart';
import 'package:mobizapp/Utilities/rest_ds.dart';
import 'package:mobizapp/confg/appconfig.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../Models/customercodemodel.dart';
import '../Models/provincemodelclass.dart';
import '../Models/routedatamodelclass.dart';
import '../confg/sizeconfig.dart';

class CustomerRegistration extends StatefulWidget {
  static const routeName = "/CustomerRegistartion";
  const CustomerRegistration({super.key});

  @override
  State<CustomerRegistration> createState() => _CustomerRegistrationState();
}

class _CustomerRegistrationState extends State<CustomerRegistration> {
  File? _image;
  bool _initDone = false;

  int cud = 0;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  bool _isUpdate = false;

  final _formKey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
  var _codeController = TextEditingController();
  var _addressController = TextEditingController();
  var _contactNumberController = TextEditingController();
  var _whatsappNumberController = TextEditingController();
  var _emailController = TextEditingController();
  final _trnController = TextEditingController();
  final _creditDays = TextEditingController();
  final _creditLimit = TextEditingController();

  String? _selectPaymentTerms;
  String? _selectedRoute;
  String? _selectedProvince;
  String? _selectCuCode;

  RouteDataModel route = RouteDataModel();
  ProvinceDataModel province = ProvinceDataModel();
  CustomerCodeModel cuCode = CustomerCodeModel();

  final List<String> paymentTerms = ['CASH', 'CREDIT', 'BILLTOBILL'];
  final List<String> routes = ['a'];
  final List<String> provinces = ['Province 1'];
  final List<String> cuCodeData = ['Province 1'];
  @override
  void initState() {
    super.initState();
    _getRoutes()
        .then((value) => _getProvince().then((value) => _getCodeData()));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _addressController.dispose();
    _contactNumberController.dispose();
    _whatsappNumberController.dispose();
    _emailController.dispose();
    _trnController.dispose();
    _creditDays.dispose();
    _creditLimit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final Map<String, dynamic>? params =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      _nameController.text = params!['name'] ?? '';
      _addressController.text = params['address'] ?? '';
      _contactNumberController.text = params!['phone'] ?? '';
      // _selectPaymentTerms = params!['payment_terms']??'';
      if (params['credit_days'] != null && params['credit_days'] != '') {
        _creditDays.text = params['credit_days'].toString();
      }
      if (params['credit_limit'] != null && params['credit_limit'] != '') {
        _creditLimit.text = params!['credit_limit'].toString();
      }

      _emailController.text = params!['email'] ?? '';

      _isUpdate = true;
    }
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              'Registration',
              style: TextStyle(color: AppConfig.backButtonColor),
            ),
            backgroundColor: AppConfig.colorPrimary,
            iconTheme: const IconThemeData(color: AppConfig.backButtonColor)),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: (!_initDone)
                ? Shimmer.fromColors(
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
                  )
                : Column(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SizedBox(
                              width: 150,
                              height: 150,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: Colors.grey, width: 2),
                                      image: _image != null
                                          ? DecorationImage(
                                              image: FileImage(_image!),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                    ),
                                    child: _image == null
                                        ? const Center(
                                            child: Text('Select Image'),
                                          )
                                        : null,
                                  ),
                                  if (_image != null)
                                    Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: GestureDetector(
                                        onTap: _pickImage,
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                            color: Colors.black54,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppConfig.colorPrimary)),
                                    labelText: 'Name',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) =>
                                      _validateNotEmpty(value, 'Name'),
                                ),
                                CommonWidgets.verticalSpace(2),
                                _buildDropdownField(
                                  label: 'Code',
                                  items: cuCodeData,
                                  value: _selectCuCode,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectCuCode = value;
                                    });
                                  },
                                ),
                                // TextFormField(
                                //   controller: _codeController,
                                //   decoration: const InputDecoration(
                                //     focusedBorder: OutlineInputBorder(
                                //         borderSide: BorderSide(
                                //             color: AppConfig.colorPrimary)),
                                //     labelText: 'Code',
                                //     border: OutlineInputBorder(),
                                //   ),
                                //   validator: (value) =>
                                //       _validateNotEmpty(value, 'Code'),
                                // ),
                                CommonWidgets.verticalSpace(2),
                                TextFormField(
                                  controller: _addressController,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppConfig.colorPrimary)),
                                    labelText: 'Address',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) =>
                                      _validateNotEmpty(value, 'Address'),
                                ),
                                CommonWidgets.verticalSpace(2),
                                TextFormField(
                                  controller: _contactNumberController,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppConfig.colorPrimary)),
                                    labelText: 'Contact Number',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) =>
                                      _validateNumber(value, 'Contact Number'),
                                ),
                                CommonWidgets.verticalSpace(2),
                                TextFormField(
                                  controller: _whatsappNumberController,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppConfig.colorPrimary)),
                                    labelText: 'WhatsApp Number',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) =>
                                      _validateNumber(value, 'WhatsApp Number'),
                                ),
                                CommonWidgets.verticalSpace(2),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppConfig.colorPrimary)),
                                    labelText: 'Email',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: _validateEmail,
                                ),
                                CommonWidgets.verticalSpace(2),
                                TextFormField(
                                  controller: _trnController,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppConfig.colorPrimary)),
                                    labelText: 'TRN',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) =>
                                      _validateNotEmpty(value, 'TRN'),
                                ),
                                CommonWidgets.verticalSpace(2),
                                _buildDropdownField(
                                  label: 'Payment Terms',
                                  items: paymentTerms,
                                  value: _selectPaymentTerms,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectPaymentTerms = value;
                                    });
                                  },
                                ),

                                (_selectPaymentTerms == "CREDIT")
                                    ? CommonWidgets.verticalSpace(2)
                                    : Container(),
                                (_selectPaymentTerms == "CREDIT")
                                    ? TextFormField(
                                        controller: _creditLimit,
                                        decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      AppConfig.colorPrimary)),
                                          labelText: 'Credit Limit',
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: (value) => _validateNotEmpty(
                                            value, 'Credit Limit'),
                                      )
                                    : Container(),
                                (_selectPaymentTerms == "CREDIT")
                                    ? CommonWidgets.verticalSpace(2)
                                    : Container(),
                                (_selectPaymentTerms == "CREDIT")
                                    ? TextFormField(
                                        controller: _creditDays,
                                        decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      AppConfig.colorPrimary)),
                                          labelText: 'Credit Days',
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: (value) => _validateNotEmpty(
                                            value, 'Credit Days'),
                                      )
                                    : Container(),
                                CommonWidgets.verticalSpace(2),
                                _buildDropdownField(
                                  label: 'Route',
                                  items: routes,
                                  value: _selectedRoute,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedRoute = value;
                                    });
                                  },
                                ),
                                CommonWidgets.verticalSpace(2),
                                _buildDropdownField(
                                  label: 'Province',
                                  items: provinces,
                                  value: _selectedProvince,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedProvince = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 35,
                                  height: SizeConfig.blockSizeVertical * 5,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                      backgroundColor:
                                          const MaterialStatePropertyAll(
                                              AppConfig.colorPrimary),
                                    ),
                                    onPressed: _submitForm,
                                    child: Text(
                                      'SAVE',
                                      style: TextStyle(
                                          fontSize: AppConfig.textCaption3Size,
                                          color: AppConfig.backgroundColor,
                                          fontWeight: AppConfig.headLineWeight),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ));
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _postRecord();
    }
  }

  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validateNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    final numberRegex = RegExp(r'^[0-9]+$');
    if (!numberRegex.hasMatch(value)) {
      return 'Please enter a valid $fieldName';
    }
    return null;
  }

  Widget _buildDropdownField(
      {required String label,
      required List<String> items,
      required String? value,
      required void Function(String?) onChanged}) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppConfig.colorPrimary)),
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      value: value,
      onChanged: onChanged,
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      validator: (value) => value == null ? 'Please select $label' : null,
    );
  }

  Future<void> _getRoutes() async {
    RestDatasource api = RestDatasource();
    dynamic resJson = await api.getDetails(
        '/api/get_route?store_id=${AppState().storeId}', AppState().token);
    route = RouteDataModel.fromJson(resJson);
    if (route.data != null) {
      routes.clear();
      for (var i in route.data!) {
        routes.add(i.code!);
      }
    }
  }

  Future<void> _getProvince() async {
    RestDatasource api = RestDatasource();
    dynamic resJson =
        await api.getDetails('/api/get_province/', AppState().token);

    province = ProvinceDataModel.fromJson(resJson);
    if (province.data != null) {
      provinces.clear();
      for (var i in province.data!) {
        provinces.add(i.name!);
      }
    }
  }

  Future<void> _getCodeData() async {
    RestDatasource api = RestDatasource();
    dynamic resJson = await api.getDetails(
        '/api/get_customer_code?store_id=${AppState().storeId}',
        AppState().token);
    cuCode = CustomerCodeModel.fromJson(resJson);
    if (cuCode.result!.data != null) {
      cuCodeData.clear();
      // for (var i in cuCode.result.data) {
      cuCodeData.add(cuCode.result!.data!);
      // }
    }
    setState(() {
      _initDone = true;
    });
  }

  Future _postRecord() async {
    int? pId;
    int? rId;
    for (var data in province.data!) {
      if (data.name == _selectedProvince) {
        pId = data.id;
        break;
      }
    }
    for (var data in route.data!) {
      if (data.code == _selectedRoute) {
        rId = data.id;
        break;
      }
    }

    RestDatasource api = RestDatasource();
    Map<String, dynamic> bodyJson = {
      "name": _nameController.text,
      "code": _selectCuCode,
      'address': _addressController.text,
      'contact_number': _contactNumberController.text,
      'whatsapp_number': _whatsappNumberController.text,
      'email': _emailController.text,
      'trn': _trnController.text,
      'payment_terms': _selectPaymentTerms,
      'route_id': rId,
      'provience_id': pId,
      'store_id': AppState().storeId,
      if (_creditLimit.text.isNotEmpty) 'credi_limit': _creditLimit.text,
      if (_creditDays.text.isNotEmpty) 'credi_days': _creditDays.text,
    };
    print('Body data $bodyJson');
    dynamic resJson = await api.customerRegister(
        AppState().token, bodyJson, _image, context, _isUpdate);
    print('Response data $resJson');
    // if (resJson["data"] != null) {
    if (mounted) {
      CommonWidgets.showDialogueBox(
              context: context, title: "", msg: "Data Inserted Successfully")
          .then((value) =>
              Navigator.pushReplacementNamed(context, HomeScreen.routeName));
    }
    // } else {
    //   if (mounted) {
    //     CommonWidgets.showDialogueBox(
    //         context: context, title: "Alert", msg: "Something went wrong");
    //   }
    // }
  }
}
