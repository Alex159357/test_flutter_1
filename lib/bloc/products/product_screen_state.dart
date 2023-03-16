

abstract class ProductListScreenState{
  const ProductListScreenState();
}

class InitialProductListScreenState extends ProductListScreenState{
  const InitialProductListScreenState();
}

class LoadingProductListScreenState extends ProductListScreenState{}

class ErrorLoadingProductListScreenState extends ProductListScreenState{
  final String message;

  ErrorLoadingProductListScreenState(this.message);
}