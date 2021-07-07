import 'package:http/http.dart' as http;
import 'package:http_repository/http_repository.dart';

abstract class RepositoryCRUD {

  String get api;

  Future<Response> select(Map<String, String> params) {
    return Repository.get("$api/select", body: params);
  }

  Future<Response> datatables(Map<String, String> params) {
    return Repository.post('$api/datatables', body: params);
  }

  Future<Response> index(Map<String, String> params) {
    return Repository.get(api, body: params);
  }

  Future<Response> store(Map<String, String> datas, {List<http.MultipartFile>? files}) {
    return Repository.multiPart('$api', 'POST', fields: datas, files: files);
  }

  Future<Response> show(int id, {Map<String, String>? params}) {
    return Repository.get("$api/$id", body: params);
  }

  Future<Response> update(int id, Map<String, String> datas, {List<http.MultipartFile>? files}) {
    return Repository.multiPart("$api/$id", 'PUT', fields: datas, files: files);
  }

  Future<Response> delete(int id, {Map<String, String>? params}) {
    return Repository.delete("$api/$id", body: params);
  }
}