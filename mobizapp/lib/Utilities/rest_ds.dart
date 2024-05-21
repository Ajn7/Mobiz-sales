import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../Models/appstate.dart';
import '../confg/EnvironmentConfig.dart';
import 'network_util.dart';

class RestDatasource {
  final NetworkUtil _netUtil = NetworkUtil();
  final AppState _appState = AppState();

  late String BASE_URL;

  RestDatasource() {
    if (EnvironmentConfig.IsProduction == "TRUE") {
      BASE_URL = "https://mobiz-api.yes45.in";
      // BASE_URL = "https://pc.felixacare.com";
    } else if (EnvironmentConfig.IsStaging == "TRUE") {
      BASE_URL ="https://mobiz-api.yes45.in";
      //  BASE_URL = "https://unistageapi.cianlogic.com";
    } else if (EnvironmentConfig.IsPVDev == "TRUE") {
      BASE_URL = "https://mobiz-api.yes45.in";
    } else {
      BASE_URL = "https://mobiz-api.yes45.in";
      //BASE_URL = "https://unistageapi.cianlogic.com";
    }
  }

  Future<String> _timeZone() async {
    String timeZone = await FlutterTimezone.getLocalTimezone();
    return timeZone;
  }

  Future<Map<String, String>> getHeader() async {
    String appVersion;
    String buildNumber;
    String osType = Platform.operatingSystem;
    String timeZone = await FlutterTimezone.getLocalTimezone();
    Map<String, String> header;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print("Felixa:App Version");
    // print("Is Production ${EnvironmentConfig.IsProduction} Server $BASE_URL");

    buildNumber = packageInfo.buildNumber;
    appVersion = packageInfo.version;
    print("Felixa:App Version $appVersion");
    print("Build Number $buildNumber");
    print("Os type $osType");
    print("Time Zone $timeZone");
    header = {
      //'${HttpHeaders.authorizationHeader}': "",
      'Content-Type': 'application/json; charset=UTF-8',
      'Os_Type': osType,
      'App_Version': appVersion,
      'Build_Number': buildNumber,
      'Time_zone': timeZone,
    };
    print("Header map in function $header");

    return header;

    // Other data you can get:
    //
    // 	String appName = packageInfo.appName;
    // 	String packageName = packageInfo.packageName;
    //	String buildNumber = packageInfo.buildNumber;
  }

  Future<dynamic> sendOtpEmail(String email) async {
    print("Felixa : email $email");
    // var header = {'Content-Type': 'application/json; charset=UTF-8'};
    var header = await getHeader();
    print("Header in sendOtp $header");
    final LOGIN_URL = BASE_URL + "/api/v1/account/send-otp/";
    try {
      final result = await InternetAddress.lookup('cianlogic.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        //Fluttertoast.showToast(msg: "Connected", backgroundColor: Colors.black);
        return _netUtil
            .post(LOGIN_URL,
                headers: header,
                body: jsonEncode(<String, String>{"email": email}))
            .then((dynamic res) {
          print(res.toString());
          return res;
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      Fluttertoast.showToast(
          msg: "No Internet Connection", backgroundColor: Colors.black);
    }
  }

  Future<dynamic> sendOtpMobile(String? code, String phone) async {
    print(phone);
    // var header = {'Content-Type': 'application/json; charset=UTF-8'};
    var header = await getHeader();
    print("Header in sendOtp $header");
    final LOGIN_URL = BASE_URL + "/api/v1/account/send-otp/";
    try {
      final result = await InternetAddress.lookup('cianlogic.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        //Fluttertoast.showToast(msg: "Connected", backgroundColor: Colors.black);
        return _netUtil
            .post(LOGIN_URL,
                headers: header,
                body: jsonEncode(<String, String?>{
                  "code": code,
                  "mobile_number": phone,
                }))
            .then((dynamic res) {
          print(res.toString());
          return res;
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      Fluttertoast.showToast(
          msg: "No Internet Connection", backgroundColor: Colors.black);
    }
  }

  Future<dynamic> sendOtp(String code, String phone, String email) async {
    print(phone);
    // var header = {'Content-Type': 'application/json; charset=UTF-8'};
    var header = await getHeader();
    print("Header in sendOtp $header");
    final LOGIN_URL = BASE_URL + "/api/v1/account/send-otp/";
    try {
      final result = await InternetAddress.lookup('cianlogic.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        //Fluttertoast.showToast(msg: "Connected", backgroundColor: Colors.black);
        return _netUtil
            .post(LOGIN_URL,
                headers: header,
                body: jsonEncode(<String, String>{
                  "code": code,
                  "mobile_number": phone,
                  "email": email
                }))
            .then((dynamic res) {
          print(res.toString());
          return res;
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      Fluttertoast.showToast(
          msg: "No Internet Connection", backgroundColor: Colors.black);
    }
  }

  Future<Map<String, dynamic>> verifyOtp(
      String? code, String? phone, String? otp) async {
    final VERIFY_OTP_URL = BASE_URL + "/api/v1/account/verify-otp/";
    var header = await getHeader();
    print("Header in verifyOtp $header");
    //var header = {'Content-Type': 'application/json; charset=UTF-8'};
    try {
      final result = await InternetAddress.lookup('cianlogic.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        //Fluttertoast.showToast(msg: "Connected", backgroundColor: Colors.black);
        return _netUtil
            .post(VERIFY_OTP_URL,
                headers: header,
                body: jsonEncode(<String, String?>{
                  "code": code,
                  "mobile_number": phone,
                  "otp": otp
                }))
            .then((Map<String, dynamic> resJson) {
          return resJson;
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      Fluttertoast.showToast(
          msg: "No Internet Connection", backgroundColor: Colors.black);
    }
    return {};
  }

  Future<Map<String, dynamic>> verifyOtpEmail(String email, String? otp) async {
    final VERIFY_OTP_URL = BASE_URL + "/api/v1/account/verify-otp/";
    var header = await getHeader();
    print("Header in verifyOtp $header");
    //var header = {'Content-Type': 'application/json; charset=UTF-8'};
    try {
      final result = await InternetAddress.lookup('cianlogic.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        //Fluttertoast.showToast(msg: "Connected", backgroundColor: Colors.black);
        return _netUtil
            .post(VERIFY_OTP_URL,
                headers: header,
                body: jsonEncode(<String, String?>{"email": email, "otp": otp}))
            .then((Map<String, dynamic> resJson) {
          return resJson;
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      Fluttertoast.showToast(
          msg: "No Internet Connection", backgroundColor: Colors.black);
    }
    return {};
  }

  Future<Map<String, dynamic>> signUpDetails(
      String? token,
      String? name,
      // String lastName,
      String? gender,
      String? dob,
      bool? isDoctor,
      String? email,
      String? qualification) async {
    // var header = {
    //   'Content-Type': 'application/json; charset=UTF-8',
    //   HttpHeaders.authorizationHeader: "token $token"
    // };
    var header = await getHeader();
    header['${HttpHeaders.authorizationHeader}'] = "token $token";
    print("Header in signUpDetails $header");
    final SIGN_UP_URL = BASE_URL + "/api/v1/account/signup/";

    try {
      final result = await InternetAddress.lookup('cianlogic.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        //Fluttertoast.showToast(msg: "Connected", backgroundColor: Colors.black);
        return _netUtil
            .post(SIGN_UP_URL,
                headers: header,
                body: jsonEncode({
                  "first_name": name,
                  // "last_name": lastName,
                  "is_doctor": isDoctor,
                  "gender": gender,
                  "dob": dob,
                  "email": email,
                  "qualification": qualification
                }))
            .then((Map<String, dynamic> resJson) {
          return resJson;
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      Fluttertoast.showToast(
          msg: "No Internet Connection", backgroundColor: Colors.black);
    }
    return {};
  }

  Future<dynamic> ScanPatient(String? PatientId, String? Token) async {
    var header = await getHeader();
    header['${HttpHeaders.authorizationHeader}'] = "token $Token";
    print("Header in ScanPatient $header");

    final SCAN_PATIENT_URL =
        BASE_URL + "/api/v1/doctor/drug-administer/?patient_id=$PatientId";

    try {
      final result = await InternetAddress.lookup('cianlogic.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        //Fluttertoast.showToast(msg: "Connected", backgroundColor: Colors.black);
        return _netUtil
            .get(
          SCAN_PATIENT_URL,
          header: header,
        )
            .then((Map<String, dynamic> resJson) {
          return resJson;
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      Fluttertoast.showToast(
          msg: "No Internet Connection", backgroundColor: Colors.black);
    }
  }

  Future<dynamic> PatientDashboard(String? PatientId, String? Token) async {
    var header = await getHeader();
    header['${HttpHeaders.authorizationHeader}'] = "token $Token";
    print("Header in PatientDashboard $header");
    // var header = {
    //   'Content-Type': 'application/json; charset=UTF-8',
    //   HttpHeaders.authorizationHeader: "token $Token"
    // };
    final SCAN_PATIENT_URL =
        BASE_URL + "/api/v1/doctor/patient-dashboard/?patient_id=$PatientId";
    try {
      final result = await InternetAddress.lookup('cianlogic.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        //Fluttertoast.showToast(msg: "Connected", backgroundColor: Colors.black);
        return _netUtil
            .get(
          SCAN_PATIENT_URL,
          header: header,
        )
            .then((Map<String, dynamic> resJson) {
          return resJson;
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      Fluttertoast.showToast(
          msg: "No Internet Connection", backgroundColor: Colors.black);
    }
  }

  Future<dynamic> patientVitals(String url, String? token) async {
    var header = await getHeader();
    header['${HttpHeaders.authorizationHeader}'] = "token $token";
    // header['${HttpHeaders.}'] = "token $token";
    print("Header in patientVitals $header");
    var extradetails = await getHeader();
    final DETAILS_URL = (url.contains("?") == true)
        ? BASE_URL +
            url +
            "&timeZone=${extradetails["Time_zone"]}&appVersion=${extradetails["App_Version"]}"
        : BASE_URL +
            url +
            "?timeZone=${extradetails["Time_zone"]}&appVersion=${extradetails["App_Version"]}";
    //final PATIENT_VITALS_URL = BASE_URL + url;
    try {
      final result = await InternetAddress.lookup('cianlogic.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        // Fluttertoast.showToast(msg: "Connected", backgroundColor: Colors.black);
        return _netUtil
            .get(
          DETAILS_URL,
          header: header,
        )
            .then((Map<String, dynamic> resJson) {
          return resJson;
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      Fluttertoast.showToast(
          msg: "No Internet Connection", backgroundColor: Colors.black);
    }
  }

  Future<dynamic> getDetails(String url, String? token) async {
    // var header = await getHeader();
    // header['${HttpHeaders.authorizationHeader}'] = "token $token";
    // print("Header in getDetails $header");
    var header;
    var extradetails = await getHeader();
    if (token == null) {
      header = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
    } else {
      print("token a ${_appState.token}");
      header = {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "token $token"
      };
    }

    final DETAILS_URL = (url.contains("?") == true)
        ? BASE_URL +
            url +
            "&timeZone=${extradetails["Time_zone"]}&appVersion=${extradetails["App_Version"]}"
        : BASE_URL +
            url +
            "?timeZone=${extradetails["Time_zone"]}&appVersion=${extradetails["App_Version"]}";
    print("Get_URL   $DETAILS_URL");
    try {
      final result = await InternetAddress.lookup('cianlogic.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return _netUtil
            .get(
          DETAILS_URL,
          header: header,
        )
            .then((Map<String, dynamic> resJson) {
          return resJson;
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      Fluttertoast.showToast(
          msg: "No Internet Connection", backgroundColor: Colors.black);
    }
  }

  Future<dynamic> getMedSearchDetails(String url, String? token) async {
    var header;
    var extradetails = await getHeader();
    if (token == null) {
      header = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
    } else {
      print("token a ${_appState.token}");
      header = {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "token $token"
      };
    }

    String BASE_URL = 'https://medsearch.cianlogic.com';

    final DETAILS_URL = (url.contains("?") == true)
        ? BASE_URL +
            url +
            "&timeZone=${extradetails["Time_zone"]}&appVersion=${extradetails["App_Version"]}"
        : BASE_URL +
            url +
            "?timeZone=${extradetails["Time_zone"]}&appVersion=${extradetails["App_Version"]}";
    print("Get_URL   $DETAILS_URL");
    try {
      final result = await InternetAddress.lookup('cianlogic.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return _netUtil
            .get(
          DETAILS_URL,
          header: header,
        )
            .then((Map<String, dynamic> resJson) {
          return resJson;
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      Fluttertoast.showToast(
          msg: "No Internet Connection", backgroundColor: Colors.black);
    }
  }

  //// Generic function : Use thsi format now onwards
  Future<Map<String, dynamic>> sendData(
      String subUrl, String? token, dynamic bodyJson) async {
    var extradetails =
        await getHeader(); // for sending appVersion/timeZone in url
    var header;
    if (token == null) {
      header = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      // header = await getHeader();
      // print("Header in sendData $header");
    } else {
      header = {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "bearer $token"
      };
      // header = await getHeader();
      // header['${HttpHeaders.authorizationHeader}'] = "token $token";
      // print("Header in sendData $header");
    }
    //String timeZone = await _timeZone();
    print("Header $header");
    final SIGN_UP_URL = (subUrl.contains("?") == true)
        ? BASE_URL +
            subUrl +
            "&timeZone=${extradetails["Time_zone"]}&appVersion=${extradetails["App_Version"]}"
        : BASE_URL +
            subUrl +
            "?timeZone=${extradetails["Time_zone"]}&appVersion=${extradetails["App_Version"]}";
    print("$SIGN_UP_URL");
    try {
      final result = await InternetAddress.lookup('cianlogic.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        if (bodyJson != null) {
          print("then $bodyJson");
          //for sending timezone and other data through body
          // Map<String,dynamic> data;
          // data = jsonDecode(bodyJson);
          // data["headerData"] = header;
          // bodyJson = jsonEncode(data);
          // print("now $bodyJson");
          //
          return _netUtil
              .post(SIGN_UP_URL, headers: header, body: bodyJson)
              .then((Map<String, dynamic> resJson) {
            return resJson;
          });
        } else {
          return _netUtil
              .post(SIGN_UP_URL, headers: header)
              .then((Map<String, dynamic> resJson) {
            return resJson;
          });
        }
      }
    } on SocketException catch (_) {
      print('not connected');
      Fluttertoast.showToast(
          msg: "No Internet Connection", backgroundColor: Colors.black);
    }
    return {};
  }

  Future<dynamic> deleteData(String url, String? token) async {
    var extradetails = await getHeader();
    var header;
    // header['${HttpHeaders.authorizationHeader}'] = "token $token";
    // print("Header in deleteData $header");
    if (token == null) {
      header = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      // header = await getHeader();
      // print("Header in sendData $header");
    } else {
      header = {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "token $token"
      };
      // header = await getHeader();
      // header['${HttpHeaders.authorizationHeader}'] = "token $token";
      // print("Header in sendData $header");
    }
    // var header = {
    //   'Content-Type': 'application/json; charset=UTF-8',
    //   HttpHeaders.authorizationHeader: "token $token"
    // };
    final DETAILS_URL = (url.contains("?") == true)
        ? BASE_URL +
            url +
            "&timeZone=${extradetails["Time_zone"]}&appVersion=${extradetails["App_Version"]}"
        : BASE_URL +
            url +
            "?timeZone=${extradetails["Time_zone"]}&appVersion=${extradetails["App_Version"]}";
    print("$DETAILS_URL");
    try {
      final result = await InternetAddress.lookup('cianlogic.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        //Fluttertoast.showToast(msg: "Connected", backgroundColor: Colors.black);
        return _netUtil
            .delete(
          DETAILS_URL,
          header: header,
        )
            .then((Map<String, dynamic> resJson) {
          return resJson;
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      Fluttertoast.showToast(
          msg: "No Internet Connection", backgroundColor: Colors.black);
    }
  }

  Future<Map<String, dynamic>> putData(
      String subUrl, String? token, dynamic bodyJson) async {
    var header;
    print("Token in restDart $token");
    if (token == null) {
      // header = {
      //   'Content-Type': 'application/json; charset=UTF-8',
      // };
      header = await getHeader();
      print("Header in putData $header");
    } else {
      // header = {
      //   'Content-Type': 'application/json; charset=UTF-8',
      //   HttpHeaders.authorizationHeader: "token $token"
      // };
      header = await getHeader();
      header['${HttpHeaders.authorizationHeader}'] = "token $token";
      print("Header in putData $header");
    }

    final SIGN_UP_URL = BASE_URL + subUrl;
    try {
      final result = await InternetAddress.lookup('cianlogic.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        // Fluttertoast.showToast(msg: "Connected", backgroundColor: Colors.black);
        return _netUtil
            .put(SIGN_UP_URL, headers: header, body: bodyJson)
            .then((Map<String, dynamic> resJson) {
          return resJson;
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      Fluttertoast.showToast(
          msg: "No Internet Connection", backgroundColor: Colors.black);
    }
    return {};
  }
}
