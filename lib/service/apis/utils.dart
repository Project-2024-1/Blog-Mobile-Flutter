import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tudotaichinh/common/exception/ApiException.dart';

import '../constant.dart';

Exception handleHttpException(http.Response response) {
  if (response.body.isNotEmpty) {
    Map<String, dynamic> body = jsonDecode(response.body);
    final String msg = body['message'];
    return Exception(msg);
  } else {
    return Exception("call api fail");
  }
}

Exception handleApiException(Map<String, dynamic> body) {
  final String msg = body['message'];
  final String? errorCode = body['code'];
  return ApiException(msg, errorCode: errorCode);
}

String getOsValue() {
  if (Platform.isIOS) {
    return OS_IOS;
  } else if (Platform.isAndroid) {
    return OS_ANDROID;
  }
  return OS_OTHER;
}
