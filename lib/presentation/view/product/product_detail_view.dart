import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_1/bloc/products/products_bloc.dart';
import 'package:test_flutter_1/bloc/products/products_state.dart';
import 'package:test_flutter_1/models/product_model.dart';

import '../../../bloc/products/products_event.dart';
import '../../sscreen/products/product_screen.dart';

class ProductDetailView extends StatelessWidget {
  ProductModel productModel;

  ProductDetailView({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Icons.keyboard_arrow_down),
        ),
        title: Text(productModel.title, overflow: TextOverflow.fade,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _getImage,
              Text(productModel.description),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$${productModel.price}", style: Theme.of(context).textTheme.labelMedium),
                    _getFavBtn
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget get _getImage =>
      CachedNetworkImage(
        imageUrl: productModel.image,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            SizedBox(width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,)),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );

  Widget get _getFavBtn => BlocBuilder<ProductsBloc, ProductsState>(builder: (BuildContext context, state) {
    final didFavorite = state.favariteList.contains(productModel.id);
    return GestureDetector(
      onTap: ()=> productsBloc.add(OnAddToFavorite(productModel.id)),
      child: Icon(didFavorite? Icons.favorite : Icons.favorite_border, size: 28, color: didFavorite? Theme.of(context).colorScheme.error  :  Colors.black,),
    );
  },);

}
