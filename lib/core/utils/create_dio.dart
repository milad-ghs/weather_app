import 'dart:developer';

import 'package:dio/dio.dart';

Dio createApiClient(String path) {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: path,
      validateStatus: (status) => true,
      connectTimeout: Duration(seconds: 60),
      sendTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60),
    ),
  );
  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (e, handler) {
        log('error : ${e.toString()}\n');
        handler.reject(e);
      },
      onRequest: (request, handler) {
        try {
          log(
            'Request => ${request.baseUrl}${request.path}'
            '\n'
            'Body => ${request.data}'
            '\n'
            'Params => ${request.queryParameters}',
          );
          // request.headers['accept'] = "text/plain";
          // request.headers['Content-Type'] = "application/json";
          handler.next(request);
        } catch (e) {
          print(e);
        }
      },
      onResponse: (e, handler) {
        log(
          'Response => ${e.realUri}'
          '\n'
          'StatusCode => ${e.statusCode}'
          '\n'
          'Data =>${e.data}',
        );
        handler.resolve(e);
      },
    ),
  );
  return dio;
}
