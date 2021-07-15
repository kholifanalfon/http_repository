import 'package:http/http.dart' as http;
import 'package:http_repository/http_repository.dart';

abstract class RepositoryCRUD {
  String get api => '';

  String get token => '';

  set token(String tokenvalue) {
    token = tokenvalue;
  }

  Map<String, String> get headers {
    Map<String, String> _headers = {};
    if(token != '')
      _headers.addAll({'Authorization': 'Bearer $token'});
    
    return _headers;
  }

  set headers(Map<String, String> headersValue) {
    if(token != '')
      headersValue.addAll({'Authorization': 'Bearer $token'});

    headers = headersValue;
  }

  Future<Response> select(Map<String, String> params) {
    return Repository.get("$api/select", body: params, headers: headers);
  }

  Future<Response> datatables(Map<String, String> params) {
    return Repository.post('$api/datatables', body: params, headers: headers);
  }

  Future<Response> index(Map<String, String> params) {
    return Repository.get(api, body: params, headers: headers);
  }

  Future<Response> store(Map<String, String> datas, {List<http.MultipartFile>? files}) {
    return Repository.multiPart('$api', 'POST', fields: datas, files: files, headers: headers);
  }

  Future<Response> show(int id, {Map<String, String>? params}) {
    return Repository.get("$api/$id", body: params, headers: headers);
  }

  Future<Response> update(int id, Map<String, String> datas, {List<http.MultipartFile>? files}) {
    return Repository.multiPart("$api/update/$id", 'POST', fields: datas, files: files, headers: headers);
  }

  Future<Response> delete(int id, {Map<String, String>? params}) {
    return Repository.post("$api/delete/$id", body: params, headers: headers);
  }
}