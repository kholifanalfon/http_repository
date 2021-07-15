import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_repository/http_repository.dart';

class Repository {

  static String api = '';
  static String requestFailedMessage = 'Mohon maaf atas ketidaknyamanannya, telah terjadi kesalah pada program. Tekan "SUBMIT ERROR" dan segera hubungi admin untuk informasi lebih lanjut.';

  static http.Client _client = http.Client();

  static Future<Response> post(url, {
    Map<String, String>? headers, Map<String, String>? body, Encoding? encoding
  }) async {

    try {
      Map<String, String> merger = new Map<String, String>();

      merger.addAll({
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      });

      print(merger);
      print('');
      if(headers != null) merger.addAll(headers);
      print(merger);

      final response = await _client.post(Uri.parse(url), headers: merger, body: body, encoding: encoding);

      return Response.fromJSON(json.decode(response.body));
    } catch(e) {
      return Response(result: false, status: 500, message: requestFailedMessage);
    }
  }

  static Future<Response> put(url, {
    Map<String, String>? headers, Map<String, String>? body, Encoding? encoding
  }) async {

    try {
      Map<String, String> merger = new Map<String, String>();

      merger.addAll({
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      });

      if(headers != null) merger.addAll(headers);

      final response = await _client.put(url, headers: merger, body: body, encoding: encoding);

      return Response.fromJSON(json.decode(response.body));
    } catch(e) {
      return Response(result: false, status: 500, message: requestFailedMessage);
    }
  }

  static Future<Response> get(url, {
    Map<String, String>? headers, Map<String, String>? body, Encoding? encoding
  }) async {

    try {

      Uri newUrl;
      if(url.toString().indexOf('https') > -1) {
        String hostDir = api.replaceAll('https://', '');
        String host = hostDir.indexOf('/') > -1 ? hostDir.substring(0, hostDir.indexOf('/')) : hostDir;
        String dir = hostDir.indexOf('/') > - 1 ? hostDir.replaceAll(host, '').substring(1) : '';
        String request = dir + url.toString().replaceAll(api, '');

        newUrl = Uri.https(host, request, body);
      } else {
        String hostDir = api.toString().replaceAll('http://', '');
        String host = hostDir.indexOf('/') > -1 ? hostDir.substring(0, hostDir.indexOf('/')) : hostDir;
        String dir = hostDir.indexOf('/') > - 1 ? hostDir.replaceAll(host, '').substring(1) : '';
        String request = dir + url.toString().replaceAll(api, '');

        newUrl = Uri.http(host, request, body);
      }

      Map<String, String> merger = new Map<String, String>();

      merger.addAll({
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      });

      if(headers != null) merger.addAll(headers);

      final response = await _client.get(newUrl, headers: merger);

      return Response.fromJSON(json.decode(response.body));
    } catch(e) {
      return Response(result: false, status: 500, message: requestFailedMessage);
    }
  }

  static Future<Response> delete(url, {
    Map<String, String>? headers, Map<String, String>? body, Encoding? encoding
  }) async {

    try {
      Uri newUrl;
      if(url.toString().indexOf('https') > -1) {
        String hostDir = api.toString().replaceAll('https://', '');
        String host = hostDir.indexOf('/') > -1 ? hostDir.substring(0, hostDir.indexOf('/')) : hostDir;
        String dir = hostDir.indexOf('/') > - 1 ? hostDir.replaceAll(host, '').substring(1) : '';
        String request = dir + url.toString().replaceAll(api, '');

        newUrl = Uri.https(host, request, body);
      } else {
        String hostDir = api.toString().replaceAll('http://', '');
        String host = hostDir.indexOf('/') > -1 ? hostDir.substring(0, hostDir.indexOf('/')) : hostDir;
        String dir = hostDir.indexOf('/') > - 1 ? hostDir.replaceAll(host, '').substring(1) : '';
        String request = dir + url.toString().replaceAll(api, '');

        newUrl = Uri.http(host, request, body);
      }

      Map<String, String> merger = new Map<String, String>();

      merger.addAll({
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      });

      if(headers != null) merger.addAll(headers);

      final response = await _client.delete(newUrl, headers: merger);

      return Response.fromJSON(json.decode(response.body));
    } catch(e) {
      return Response(result: false, status: 500, message: requestFailedMessage);
    }
  }

  static Future<Response> multiPart(url, String method, {Map<String, String>? fields, List<http.MultipartFile>? files, Map<String, String>? headers}) async {
    try {

      final req = http.MultipartRequest(method, Uri.parse(url));

      if(fields != null)
        req.fields.addAll(fields);

      if(files != null)
        req.files.addAll(files);

      if(headers != null)
        req.headers.addAll(headers);

      http.Response response = await http.Response.fromStream(await req.send());

      return Response.fromJSON(json.decode(response.body));
    } catch(e) {
      return Response(result: false, status: 500, message: requestFailedMessage);
    }
  }
}