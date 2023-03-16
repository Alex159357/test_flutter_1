import '../../models/product_model.dart';

abstract class ProductsEvent {}

class InitProductEvent extends ProductsEvent {}

class OnSearchValueChanged extends ProductsEvent{
  final String searchRequ;

  OnSearchValueChanged(this.searchRequ);
}

class OnAddToFavorite extends ProductsEvent{
  final int itemId;

  OnAddToFavorite(this.itemId);
}

class OnRefreshPulled extends ProductsEvent{
  final List<ProductModel>? products;

  OnRefreshPulled(this.products);
}