import 'package:test_flutter_1/bloc/products/product_screen_state.dart';
import 'package:test_flutter_1/models/product_model.dart';

class ProductsState {
  final List<ProductModel> products;
  final String searchReq;
  final List<int> favariteList;
  final ProductListScreenState productListScreenState;

  ProductsState(
      {this.products = const [],
      this.searchReq = "",
      this.favariteList = const [],
      this.productListScreenState = const InitialProductListScreenState()});

  ProductsState clone(
          {List<ProductModel>? products,
          String? searchReq,
          List<int>? favaritList,
          ProductListScreenState? productListScreenState}) =>
      ProductsState(
          products: products ?? this.products,
          searchReq: searchReq ?? this.searchReq,
          favariteList: favaritList ?? this.favariteList,
          productListScreenState:
              productListScreenState ?? this.productListScreenState);
}
