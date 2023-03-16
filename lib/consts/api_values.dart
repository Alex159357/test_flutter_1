

enum ApiValues{
  FETCH_PRODUCT_LIST, LOGIN
}

extension ApiValuesExt on ApiValues{

  String get url{
    switch(this){
      case ApiValues.FETCH_PRODUCT_LIST: return "products";
      case ApiValues.LOGIN: return "auth/login";
    }
  }

}