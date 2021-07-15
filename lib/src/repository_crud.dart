import 'package:http/http.dart' as http;
import 'package:http_repository/http_repository.dart';

abstract class RepositoryCRUD {
  String get api => '';

  Future<String> get token => Future(() => '');

  Future<Map<String, String>> get _headers async {
    Map<String, String> _headers = {};

    String _token = await token;
    if(_token != '')
      _headers.addAll({'Authorization': 'Bearer $token'});

    print(_headers);
    
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
    return Repository.multiPart('$api', 'POST', fields: datas, files: files, headers: await _headers);
  }

  Future<Response> show(int id, {Map<String, String>? params}) async {
    return Repository.get("$api/$id", body: params, headers: await _headers);
  }

  Future<Response> update(int id, Map<String, String> datas, {List<http.MultipartFile>? files}) async {
    return Repository.multiPart("$api/update/$id", 'POST', fields: datas, files: files, headers: await _headers);
  }

  Future<Response> delete(int id, {Map<String, String>? params}) async {
    return Repository.post("$api/delete/$id", body: params, headers: await _headers);
  }
}