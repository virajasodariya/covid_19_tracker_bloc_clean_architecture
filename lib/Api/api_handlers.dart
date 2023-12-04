import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'app_exception.dart';

enum APIType { aPost, aGet, aPut, aPatch }

class APIService {
  Future<dynamic> getResponse({
    required String url,
    required APIType apiType,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool fileUpload = false,
  }) async {
    headers ??= {};

    try {
      http.Response result;

      switch (apiType) {
        case APIType.aGet:
          log('GET Request: $url');
          result = await http.get(Uri.parse(url), headers: headers);
          break;
        case APIType.aPost:
          log('POST Request: $url, Body: ${jsonEncode(body)}');
          result = await http.post(Uri.parse(url),
              body: jsonEncode(body), headers: headers);
          break;
        case APIType.aPut:
          log('PUT Request: $url, Body: ${jsonEncode(body)}');
          result = await http.put(Uri.parse(url),
              body: jsonEncode(body), headers: headers);
          break;
        case APIType.aPatch:
          log('PATCH Request: $url, Body: ${jsonEncode(body)}');
          result = await http.patch(Uri.parse(url),
              body: jsonEncode(body), headers: headers);
          break;
        default:
          throw Exception('APIType not supported');
      }

      log('Response Status Code: ${result.statusCode}');
      log('Response Body: ${result.body}');

      return returnResponse(result.statusCode, result.body);
    } on SocketException {
      log('No Internet connection');
      throw FetchDataException('No Internet access');
    } catch (e) {
      log('Error: $e');
      rethrow;
    }
  }

  dynamic returnResponse(int status, String result) {
    switch (status) {
      case 200:
      case 201:
        return jsonDecode(result);
      case 400:
        throw BadRequestException(jsonDecode(result)['message']);
      case 401:
        throw UnauthorisedException(jsonDecode(result)['message']);
      case 404:
        throw ServerException('Server Error');
      case 500:
      default:
        throw FetchDataException('Internal Server Error');
    }
  }
}
