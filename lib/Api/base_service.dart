import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:watchit/Model/response_model.dart';

import 'api_exception.dart';

class BaseApiHelper {
  static Future<dynamic> getRequest({required String requestUrl}) async {
    return await http
        .get(Uri.parse(requestUrl))
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error));
  }

  static Future onValue(http.Response response) async {
    final ResponseItem result = ResponseItem();
    dynamic data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      result.data = data;
    } else if (response.statusCode == 400 || response.statusCode == 401) {
    } else {
      // CommonSnackbar().errorSnackbar(context: ctx!, message: "Invalid Status");
    }
    return result;
  }

  static onError(error) {
    debugPrint("error--------------> $error");
    String message = "Unsuccessful request";
    if (error is SocketException) {
      message = ResponseException("No internet connection").toString();
    } else if (error is FormatException) {}
    return ResponseItem(data: {'message': message}, success: false);
  }
}
