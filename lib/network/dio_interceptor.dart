

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/mapper.dart';

class DioInterceptor<T> extends Interceptor with Mapper<T>{


  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print("real_request: ${options.data}");
    }
    options.connectTimeout = const Duration(minutes: 5);
    options.receiveTimeout = const Duration(minutes: 5);
    options.baseUrl = "https://fakestoreapi.com/";
    options.headers['content-Type'] = 'application/json';
    options.headers['accept'] = 'application/json';
    options.headers['access-control-allow-origin'] = '*';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print("real_response: ${response.data}");
    }
    response.data = mapToModel(response.data);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {

    super.onError(err, handler);
  }

}