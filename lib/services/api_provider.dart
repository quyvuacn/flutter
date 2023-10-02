import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class ApiProvider {
  Dio _dio = Dio();
  Options _options = Options();

  ApiProvider(BaseOptions? baseOptions) {
    if(baseOptions == null) {
      _dio = Dio(BaseOptions(baseUrl: dotenv.env['BASE_URL'] ?? ''));
    } else {
      _dio = Dio(baseOptions);
    }
  }

  void setToken(String token) {
    var headers = _options.headers;
    _options = Options(headers: {...?headers, 'Authorization': 'Bearer $token'});
  }

  void setRefreshToken(String refreshToken) {
    var headers = _options.headers;
    _options = Options(headers: {...?headers, 'Refresh Token': refreshToken});
  }

  void setAttrHeaders(String key, String value) {
    var headers = _options.headers;
    _options = Options(headers: {...?headers, key: value});
  }

  Future<Response> get(String path, Map<String, dynamic>? params) async {
    return _dio.get(path, queryParameters: params, options: _options);
  }

  Future<Response> post(String path, Map<String, dynamic>? data) async {
    return _dio.post(path, data: data, options: _options);
  }

  Future<Response> patch(String path, Map<String, dynamic>? data) async {
    return _dio.patch(path, data: data, options: _options);
  }

  Future<Response> delete(String path, Map<String, dynamic>? data) async {
    return _dio.delete(path, data: data, options: _options);
  }
}
