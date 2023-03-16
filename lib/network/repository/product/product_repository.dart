

import 'package:test_flutter_1/models/product_model.dart';

abstract class ProductRepository{

  Future<List<ProductModel>?> fetchProducts();

}