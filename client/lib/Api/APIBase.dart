import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:client/Api/APIConfig.dart';
import 'package:http/http.dart' as http;

import 'exceptionBase.dart';

class APIBase {
  final String base_url = API_BASE_URL;

  // Post
  Future<dynamic> postRequest(String url, dynamic bodyParam,
      {Map<String, String>? headers}) async {
    Uri uri = Uri.parse("${base_url}${url}");
    http.Response response;
    var responseJson;
    try {
      if (headers == null) {
        response = await http
            .post(uri, body: bodyParam)
            .timeout(Duration(seconds: 120));
      } else {
        response = await http
            .post(uri, body: bodyParam, headers: headers)
            .timeout(Duration(seconds: 120));
      }
      responseJson = _decodeResponse(response);
    } on SocketException {
      throw FetchDataException("Internet error");
    } on TimeoutException {
      throw FetchDataException("Timeout");
    }
    return responseJson;
  }

  // Get
  Future<dynamic> getRequest(String url, {Map<String, String>? headers}) async {
    Uri uri = Uri.parse("${base_url}${url}");
    http.Response response;
    var responseJson;
    try {
      if (headers == null) {
        response = await http.get(uri).timeout(Duration(seconds: 120));
      } else {
        response = await http
            .get(uri, headers: headers)
            .timeout(Duration(seconds: 120));
      }
      responseJson = _decodeResponse(response);
    } on SocketException {
      throw FetchDataException("Internet error");
    } on TimeoutException {
      throw FetchDataException("Timeout");
    }
    return responseJson;
  }

  _decodeResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        Map<String, dynamic> responseJson =
            json.decode(response.body.toString());
        if (responseJson['success'] == false) {
          throw Exception(responseJson['message']);
        }
        return responseJson;
      case 400:
      case 404:
      case 401:
      case 403:
        Map<String, dynamic> responseJson =
            json.decode(response.body.toString());
        if (responseJson['success'] == false) {
          throw Exception(responseJson['message']);
        }
        return responseJson;
      case 500:
      default:
        throw FetchDataException(
            "Error occured while Communication with Server with StatusCode : ${response.statusCode}");
    }
  }
}
