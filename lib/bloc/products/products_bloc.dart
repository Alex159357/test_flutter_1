import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:test_flutter_1/bloc/products/product_screen_state.dart';

import '../../models/product_model.dart';
import '../../network/repository/product/product_repository.dart';
import '../../network/repository/product/product_repository_impl.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository _productRepository = ProductRepositoryImpl();

  ProductsBloc() : super(ProductsState()) {
    on<InitProductEvent>(_init);
    on<OnSearchValueChanged>(_onSearchValueChanged);
    on<OnAddToFavorite>(_onAddToFavorite);
    on<OnRefreshPulled>(_onRefreshPulled);
  }

  void _init(InitProductEvent event, Emitter<ProductsState> emit) async {
    emit(state.clone(productListScreenState: LoadingProductListScreenState()));
    try {
      List<ProductModel>? products = await _productRepository.fetchProducts();
      if (products != null) {
        emit(state.clone(products: products, productListScreenState: const InitialProductListScreenState()),);
      } else {
        emit(state.clone(productListScreenState: ErrorLoadingProductListScreenState("No items in list")),);
      }
    }catch(e){
      emit(state.clone(productListScreenState:  ErrorLoadingProductListScreenState(e.toString())),);
    }
  }

  FutureOr<void> _onSearchValueChanged(OnSearchValueChanged event, Emitter<ProductsState> emit) {
    emit(state.clone(searchReq: event.searchRequ));
  }

  FutureOr<void> _onAddToFavorite(OnAddToFavorite event, Emitter<ProductsState> emit) {
    List<int> newFavList = [];
    newFavList.addAll(state.favariteList);
    if(state.favariteList.contains(event.itemId)){
      newFavList.removeWhere((element) => element == event.itemId);
    }else{
      newFavList.add(event.itemId);
    }
    emit(state.clone(favaritList: newFavList));
    //TODO make changes in database
  }

  FutureOr<void> _onRefreshPulled(OnRefreshPulled event, Emitter<ProductsState> emit) {
    if (event.products != null) {
      emit(state.clone(products: event.products, productListScreenState: const InitialProductListScreenState()),);
    } else {
      emit(state.clone(productListScreenState: ErrorLoadingProductListScreenState("No items in list")),);
    }
  }

  Future<void> updateList() async{
    List<ProductModel>? products = await _productRepository.fetchProducts();
    add(OnRefreshPulled(products));
  }

}
