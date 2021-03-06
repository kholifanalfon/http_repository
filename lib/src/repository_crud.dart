import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_repository/http_repository.dart';

abstract class RepositoryCRUD {
  String get api => '';

  Future<String> get credentials => Future(() => '');

  Future<Map<String, String>> get _headers async {
    Map<String, String> _headers = {};

    String _token = await credentials;
    if(_token != '')
      _headers.addAll({HttpHeaders.authorizationHeader: _token});
    
    return _headers;
  }

  Future<Response> select(Map<String, String> params) async {
    return Repository.get("$api/select", body: params, headers: await _headers);
  }

  Future<Response> datatables(Map<String, String> params) async {
    return Repository.post('$api/datatables', body: params, headers: await _headers);
  }

  Future<Response> index(Map<String, String> params) async {
    return Repository.get(api, body: params, headers: await _headers);
  }

  Future<Response> store(Map<String, String> datas, {List<http.MultipartFile>? files}) async {
    return Repository.post(api, body: datas, headers: await _headers);
  }

  Future<Response> show(int id, {Map<String, String>? params}) async {
    return Repository.get("$api/$id", body: params, headers: await _headers);
  }

  Future<Response> update(int id, Map<String, String> datas, {List<http.MultipartFile>? files}) async {
    return Repository.put("$api/$id", body: datas, headers: await _headers);
  }

  Future<Response> delete(int id, {Map<String, String>? params}) async {
    return Repository.delete("$api/$id", body: params, headers: await _headers);
  }
}