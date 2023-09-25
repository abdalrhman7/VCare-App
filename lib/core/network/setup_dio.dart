import 'package:dio/dio.dart';

Dio createAndSetupDio() {
  Dio dio = Dio();

  dio
    ..options.connectTimeout = const Duration(milliseconds: 200 * 1000)
    ..options.receiveTimeout = const Duration(milliseconds: 200 * 1000);

  dio.interceptors.add(LogInterceptor(
    // responseBody: true,
    error: true,
    requestHeader: false,
    responseHeader: false,
    request: true,
    requestBody: true,
  ));
  return dio;
}
