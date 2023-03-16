

import 'package:test_flutter_1/consts/api_values.dart';

abstract class Client{

  Future<dynamic> fetchData(ApiValues apiValues);

  Future<dynamic> postData({required Map<String, dynamic> data, required ApiValues apiValues});

}