import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<Map<String, dynamic>> get(String url, {Map? header}) {
    print(url);
    return http
        .get(
      Uri.parse(url),
      headers: header as Map<String, String>?,
    )
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print(res);
      print('Response code: $statusCode');
      if (statusCode < 200 || statusCode > 400 || json == null) {
        if (statusCode == 401 || statusCode == 403) {
          Map<String, dynamic> resJson = {
            "status": "error",
            "status_code": response.statusCode,
          };
          return resJson;
        } else if (statusCode >= 500) {
          Map<String, dynamic> resJson = {
            "status": "error",
            "status_code": response.statusCode,
          };
          return resJson;
        }
        throw new Exception("Error while fetching data");
      }
      Map<String, dynamic> resJson = {};
      if (res.contains("status")) {
        resJson = json.decode(response.body);
      } else {
        resJson = {
          'status': "success",
          "result": json.decode(response.body),
        };
      }
      return resJson;
    });
  }

  Future<Map<String, dynamic>> post(String url,
      {Map? headers, body, encoding}) {
    print(headers);
    print(body);
    print(encoding);
    print(url);
    Map<String, dynamic>? resJson;
    return http
        .post(Uri.parse(url),
            body: body,
            headers: headers as Map<String, String>?,
            encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print("Status code $statusCode");
      if (statusCode < 200 || statusCode > 400 || json == null) {
        if (statusCode == 401 || statusCode == 403 || statusCode == 500) {
          resJson = {
            "status": "error",
            "status_code": response.statusCode,
          };
          return resJson!;
        }
        throw new Exception("Error while fetching data");
      }
      //return _decoder.convert(res);
      resJson = json.decode(response.body);
      return resJson!;
    });
  }

  Future<Map<String, dynamic>> delete(String url, {Map? header}) {
    print(url);
    return http
        .delete(
      Uri.parse(url),
      headers: header as Map<String, String>?,
    )
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print("CP: statuscode $statusCode");
      print(res);
      if (statusCode == 204) {
        Map<String, dynamic> resJson = {
          "status": "success",
          "status_code": response.statusCode,
          "message": "Successfully deleted",
        };
        return resJson;
      }
      if (statusCode < 200 || statusCode > 400 || json == null) {
        if (statusCode == 401 || statusCode == 403) {
          Map<String, dynamic> resJson = {
            "status": "error",
            "status_code": response.statusCode,
          };
          return resJson;
        }
        throw new Exception("Error while fetching data");
      }
      Map<String, dynamic> resJson = json.decode(response.body);
      return resJson;
    });
  }

  Future<Map<String, dynamic>?> deleted(String url,
      {required Map header, body, encoding}) async {
    print(url);
    final request = http.Request("DELETE", Uri.parse(url));
    request.headers.addAll(header as Map<String, String>);
    request.body = jsonEncode(body);
    final response = await request.send();
    final int statusCode = response.statusCode;
    print("Status Code $statusCode");
    if (statusCode < 200 || statusCode > 400 || json == null) {
      if (statusCode == 401 || statusCode == 403) {
        Map<String, dynamic> resJson = {
          "status": "error",
          "status_code": response.statusCode,
        };
        return resJson;
      }
      throw new Exception("Error while fetching data");
    }
    final String res = await response.stream.bytesToString();
    print("Responnnnnnse $res");
    Map<String, dynamic>? resJson = json.decode(res);
    return resJson;
  }

  Future<Map<String, dynamic>> put(String url, {Map? headers, body, encoding}) {
    print(headers);
    print(body);
    print(encoding);
    print(url);
    return http
        .put(Uri.parse(url),
            body: body,
            headers: headers as Map<String, String>?,
            encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print("Status code $statusCode");
      print("Response ${res}");
      if (statusCode < 200 || statusCode > 400 || json == null) {
        if (statusCode == 401 || statusCode == 403) {
          Map<String, dynamic> resJson = {
            "status": "error",
            "status_code": response.statusCode,
          };
          return resJson;
        }
        throw new Exception("Error while fetching data");
      }
      //return _decoder.convert(res);
      Map<String, dynamic> resJson = json.decode(response.body);
      return resJson;
    });
  }
}

class HttpErrorHandling {
  String? status;

  HttpErrorHandling({this.status});
}
