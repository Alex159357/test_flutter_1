import 'package:test_flutter_1/models/auth_model.dart';
import 'package:test_flutter_1/models/product_model.dart';

mixin Mapper<T> {
  dynamic mapToModel(dynamic data) {
    if (data is List) {
      List<T> mList = [];
      for (var element in data) {
        final t = _map(element);
        if (t != null) {
          mList.add(t);
        }
      }
      data = mList;
    } else {
      data = _map(data);
    }
    return data;
  }

  T? _map(Map<String, dynamic> json) {
    switch (T) {
      case ProductModel:
        return ProductModel.fromJson(json) as T;
      case AuthModel:
        return AuthModel.fromJson(json) as T;
      default:
        return null;
    }
  }
}
