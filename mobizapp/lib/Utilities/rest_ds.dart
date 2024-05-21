import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../Models/appstate.dart';
import 'network_util.dart';

class RestDatasource {
  final NetworkUtil _netUtil = NetworkUtil();
  final AppState _appState = AppState();

  late String BASE_URL;

  RestDatasource() {
    BASE_URL = "https://mobiz-api.yes45.in";
    //BASE_URL = "https://unistageapi.cianlogic.com";
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
}
