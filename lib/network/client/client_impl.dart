
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_flutter_1/consts/api_values.dart';
import 'package:test_flutter_1/network/dio_interceptor.dart';
import 'client.dart';

class ClientImpl<T> extends DioInterceptor<T> implements Client{
  Dio? _dio;

  static getInstance<T>(){
    return ClientImpl<T>();
  }

  ClientImpl(){
    _dio = Dio()..interceptors.add(this);
  }

  @override
  Future<dynamic> fetchData(ApiValues apiValues) async{
     var res = await _dio!.get(apiValues.url);
     return res.data;
  }

  @override
  Future<dynamic> postData({required Map<String, dynamic> data, required ApiValues apiValues}) async{
    var res = await _dio!.post(data: data, apiValues.url);
    return res.data;
  }


}