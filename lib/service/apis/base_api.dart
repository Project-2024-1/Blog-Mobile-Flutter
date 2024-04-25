import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tudotaichinh/service/apis/utils.dart';

import '../../config/config.dart';
import '../api.dart';
import '../constant.dart';

Future<T> baseGetNewApi<T>(String path,
    {bool hasLog = true,
    String? endpoint,
    bool isAuth = true,
    Map<String, String>? additionHeaders}) async {
  final usedEndPoint = endpoint ?? Config.defaultInstance().apiEndpoint;

  final url = '$usedEndPoint$path';
  print("API $url");
  Map<String, String> headers = {};
  // headers.addAll(DEFAULT_JSON_HEADER);
  // if (isAuth) {
  //   // final accountId = await loadAccountId();
  //   // headers['accountId'] = accountId;
  //   // print("accountId $accountId");
  //   final accessToken = await loadAccessToken();
  //   headers['Authorization'] = "Bearer $accessToken";
  //   print("Authorization Bearer $accessToken");
  // }
  // if (additionHeaders != null) {
  //   headers.addAll(additionHeaders);
  // }
  // print("header: $headers");

  final response = await http.get(
    Uri.parse(url),
    headers: headers,
  );
  // print("request body: $requestBody");
  print("GET API $url: response: ${response.statusCode}");
  print("BODY: ${response.body}");
  if (response.statusCode == 200) {
    Map<String, dynamic> body = jsonDecode(response.body);
     return body as T;
    if (body['result'] == 'success') {
      return body['data'];
    } else {
      throw handleApiException(body);
    }
  } else {
    throw handleHttpException(response);
  }
}

Future<T> baseGetApi<T>(String path,
    {bool hasLog = true,
    String? endpoint,
    bool isAuth = true,
    Map<String, String>? additionHeaders}) async {
  final usedEndPoint = endpoint ?? Config.defaultInstance().apiEndpoint;

  final url = '$usedEndPoint$path';
  print("API $url");
  Map<String, String> headers = {};
  headers.addAll(DEFAULT_JSON_HEADER);
  if (isAuth) {
    // final accountId = await loadAccountId();
    // headers['accountId'] = accountId;
    // print("accountId $accountId");
    final accessToken = await loadAccessToken();
    headers['Authorization'] = "Bearer $accessToken";
    print("Authorization Bearer $accessToken");
  }
  if (additionHeaders != null) {
    headers.addAll(additionHeaders);
  }
  print("header: $headers");

  final response = await http.get(
    Uri.parse(url),
    headers: headers,
  );
  // print("request body: $requestBody");
  print("GET API $url: response: ${response.statusCode}");
  print("BODY: ${response.body}");
  if (response.statusCode == 200) {
    Map<String, dynamic> body = jsonDecode(response.body);
    if (body['result'] == 'success') {
      return body['data'];
    } else {
      throw handleApiException(body);
    }
  } else {
    throw handleHttpException(response);
  }
}

Future<T> basePostApi<T>(String path, Map<String, dynamic>? bodyMap,
    {bool hasLog = true,
    String? endpoint,
    bool isAuth = true,
    bool isGetAllResponse = false,
    Map<String, String>? additionHeaders}) async {
  final usedEndPoint = endpoint ?? Config.defaultInstance().apiEndpoint;

  final url = '$usedEndPoint$path';
  print("API $url");
  Map<String, String> headers = {};
  headers.addAll(DEFAULT_JSON_HEADER);
  if (isAuth) {
    // final accountId = await loadAccountId();
    // headers['accountId'] = accountId;
    // print("accountId $accountId");
    final accessToken = await loadAccessToken();
    headers['Authorization'] = "Bearer $accessToken";
    print("Authorization Bearer $accessToken");
  }
  if (additionHeaders != null) {
    headers.addAll(additionHeaders);
  }
  print("header: $headers");
  final requestBody = jsonEncode(bodyMap);

  debugPrint("request body: $requestBody");
  final response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: requestBody,
  );
  // print("request body: $requestBody");
  print("POST API $url: response: ${response.statusCode}");
  print("BODY: ${response.body}");
  if (response.statusCode == 200) {
    Map<String, dynamic> body = jsonDecode(response.body);
    if (body['result'] == 'success') {
      if (isGetAllResponse) {
        return body as T;
      }
      return body['data'];
    } else {
      throw handleApiException(body);
    }
  } else {
    throw handleHttpException(response);
  }
}


Future<T> baseNewPostApi<T>(String path,
    {bool hasLog = true,
      String? endpoint,
      bool isAuth = true,
      Map<String, String>? additionHeaders}) async {
  final usedEndPoint = endpoint ?? Config.defaultInstance().apiEndpoint;

  final url = '$usedEndPoint$path';
  print("API $url");
  Map<String, String> headers = {};
  headers.addAll(DEFAULT_JSON_HEADER);
  if (isAuth) {
    final accessToken = await loadAccessToken();
    headers['Authorization'] = "Bearer $accessToken";
    print("Authorization Bearer $accessToken");
  }
  if (additionHeaders != null) {
    headers.addAll(additionHeaders);
  }
  print("header: $headers");

  final response = await http.post(
    Uri.parse(url),
    headers: headers,
  );
  // print("request body: $requestBody");
  print("new API $url: response: ${response.statusCode}");
  print("BODY: ${response.body}");
  if (response.statusCode == 200) {
    Map<String, dynamic> body = jsonDecode(response.body);
    if (body['result'] == 'success') {
      return body['data'];
    } else {
      throw handleApiException(body);
    }
  } else {
    throw handleHttpException(response);
  }
}

Future<T> baseDeleteApi<T>(String path, Map<String, dynamic>? bodyMap,
    {bool hasLog = true, String? endpoint, bool isAuth = true}) async {
  final usedEndPoint = endpoint ?? Config.defaultInstance().apiEndpoint;

  final url = '$usedEndPoint$path';
  print("API $url");
  Map<String, String> headers = {};
  headers.addAll(DEFAULT_JSON_HEADER);
  // if (isAuth) {
  //   final accountId = await loadAccountId();
  //   headers['accountId'] = accountId;
  //   print("accountId $accountId");
  // }
  if (isAuth) {
    final accessToken = await loadAccessToken();
    headers['Authorization'] = "Bearer $accessToken";
    print("Authorization Bearer $accessToken");
  }

  print("header: $headers");

  final requestBody = jsonEncode(bodyMap);

  print("request body: $requestBody");
  final response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: requestBody,
  );
  // print("request body: $requestBody");
  print("DEL API $url: response: ${response.statusCode}");
  print("BODY: ${response.body}");
  if (response.statusCode == 200) {
    Map<String, dynamic> body = jsonDecode(response.body);
    if (body['result'] == 'success') {
      return body['data'];
    } else {
      throw handleApiException(body);
    }
  } else {
    throw handleHttpException(response);
  }
}

Future<T> basePutApi<T>(String path, Map<String, dynamic>? bodyMap,
    {bool hasLog = true, String? endpoint, bool isAuth = true}) async {
  final usedEndPoint = endpoint ?? Config.defaultInstance().apiEndpoint;

  final url = '$usedEndPoint$path';
  print("API $url");
  Map<String, String> headers = {};
  headers.addAll(DEFAULT_JSON_HEADER);
  if (isAuth) {
    final accountId = await loadAccessToken();
    headers['accountId'] = accountId;
    print("accountId $accountId");
  }

  final requestBody = jsonEncode(bodyMap);

  print("request body: $requestBody");
  final response = await http.put(
    Uri.parse(url),
    headers: headers,
    body: requestBody,
  );
  // print("request body: $requestBody");
  print("PUT API $url: response: ${response.statusCode}");
  print("BODY: ${response.body}");
  if (response.statusCode == 200) {
    Map<String, dynamic> body = jsonDecode(response.body);
    if (body['result'] == 'success') {
      return body['data'];
    } else {
      throw handleApiException(body);
    }
  } else {
    throw handleHttpException(response);
  }
}
