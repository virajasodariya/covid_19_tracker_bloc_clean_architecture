import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'app_exception.dart';

enum APIType { aPost, aGet, aPut, aPatch }

class APIService {
  var response;

  Future getResponse(
      {required String url,
      required APIType apitype,
      Map<String, dynamic>? body,
      Map<String, String>? header,
      bool fileUpload = false}) async {
    Map<String, String> headers = {};

    try {
      if (apitype == APIType.aGet) {
        final result = await http.get(Uri.parse(url), headers: headers);
        response = returnResponse(result.statusCode, result.body);
        //debugPrint("RES status code ${result.statusCode}");
        //debugPrint("res${result.body}");
      } else if (apitype == APIType.aPost) {
        debugPrint("REQUEST PARAMETER url  $url");
        debugPrint("REQUEST PARAMETER $body");

        final result =
            await http.post(Uri.parse(url), body: body, headers: headers);
        debugPrint("resp${result.body}");
        response = returnResponse(result.statusCode, result.body);
        log(result.statusCode.toString());
      } else if (apitype == APIType.aPut) {
        final result = await http.put(Uri.parse(url), headers: headers);
        response = returnResponse(result.statusCode, result.body);
        //debugPrint("RES status code ${result.statusCode}");
        //debugPrint("res${result.body}");
      }
    } on SocketException {
      throw FetchDataException('No Internet access');
    }

    return response;
  }

  returnResponse(int status, String result) {
    switch (status) {
      case 200:
        return jsonDecode(result);
      case 201:
        return jsonDecode(result);
      case 400:
        return jsonDecode(result);
      case 401:
        throw UnauthorisedException('Unauthorised user');
      case 404:
        throw ServerException('Server Error');
      case 500:
      default:
        throw FetchDataException('Internal Server Error');
    }
  }
}
