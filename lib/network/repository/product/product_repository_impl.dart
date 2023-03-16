

import 'package:test_flutter_1/consts/api_values.dart';
import 'package:test_flutter_1/models/product_model.dart';
import 'package:test_flutter_1/network/client/client_impl.dart';
import 'package:test_flutter_1/network/repository/product/product_repository.dart';

import '../../client/client.dart';

class ProductRepositoryImpl implements ProductRepository{

  @override
  Future<List<ProductModel>?> fetchProducts() async{
    Client client = ClientImpl.getInstance<ProductModel>();
    return await client.fetchData(ApiValues.FETCH_PRODUCT_LIST);
  }

}