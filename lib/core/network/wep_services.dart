import 'package:dio/dio.dart';

import 'api_constants.dart';

class WebService {
  final Dio _dio;

  WebService(this._dio);

  Future<Map<String, dynamic>> getData({
    required String endPoint,
    String? token,
  }) async {
    Response response = await _dio.get(endPoint,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${token ?? ''}',
          },
        ));
    return response.data;
  }

  Future<Response> postData({
    required String endPoint,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    Response response = await _dio.post(endPoint,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${token ?? ''}',
          },
        ));
    return response;
  }
}
