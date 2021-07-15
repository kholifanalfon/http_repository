import 'package:http/http.dart' as http;
import 'package:http_repository/http_repository.dart';

abstract class RepositoryCRUD {
  String get api => '';

  String get credentials => 'crendetials';

  Future<String> get token => Future(() => '');

  Future<Map<String, String>> _params(Map<String, String>? params) async {
    if(params == null)
      params = {};

    String _token = await token;
    if(_token != '') {
      params.addAll({credentials: _token});
    }
    
    return params;
  }

  Future<Response> select(Map<String, String> params) async {
    return Repository.get("$api/select", body: await _params(params));
  }

  Future<Response> datatables(Map<String, String> params) async {
    return Repository.post('$api/datatables', body: await _params(params));
  }

  Future<Response> index(Map<String, String> params) async {
    return Repository.get(api, body: await _params(params));
  }

  Future<Response> store(Map<String, String> datas, {List<http.MultipartFile>? files}) async {
    return Repository.multiPart('$api', 'POST', fields: await _params(datas), files: files);
  }

  Future<Response> show(int id, {Map<String, String>? params}) async {
    return Repository.get("$api/$id", body: await _params(params!));
  }

  Future<Response> update(int id, Map<String, String> datas, {List<http.MultipartFile>? files}) async {
    return Repository.multiPart("$api/update/$id", 'POST', fields: await _params(datas), files: files);
  }

  Future<Response> delete(int id, {Map<String, String>? params}) async {
    return Repository.post("$api/delete/$id", body: await _params(params));
  }
}