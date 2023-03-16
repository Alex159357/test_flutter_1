import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_1/bloc/products/products_bloc.dart';
import 'package:test_flutter_1/bloc/products/products_state.dart';
import 'package:test_flutter_1/models/product_model.dart';

import '../../../bloc/products/products_event.dart';
import '../../sscreen/products/product_screen.dart';
import '../../widget/catalog_grid/catalog_card.dart';
import '../product/product_detail_view.dart';

class CatalogView extends StatelessWidget {
  const CatalogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async{
          return await productsBloc.updateList();
        },
        child: _getProducts);
  }

  Widget get _getProducts => BlocBuilder<ProductsBloc, ProductsState>(
        builder: (BuildContext context, state) {
          return OrientationBuilder(builder: (context, orientation) {
            final itemCount = orientation == Orientation.portrait ? 2 : 3;
            return GridView.count(
              crossAxisCount: itemCount,
              crossAxisSpacing: 6.0,
              mainAxisSpacing: 6.0,
              children: List.generate(state.products.length, (index) {
                ProductModel it = state.products[index];
                bool didFavorite = state.favariteList.contains(it.id);


                return Container(
                  margin: EdgeInsets.only(
                      left: index % itemCount == 0 ? 25 : 0,
                      right: itemCount == 2
                          ? index % itemCount == 1
                              ? 25
                              : 0
                          : index % itemCount == 2
                              ? 25
                              : 0),
                  child: Container(
                    child: OpenContainer(
                      transitionDuration: const Duration(milliseconds: 700),
                      transitionType: ContainerTransitionType.fade,
                      openBuilder: (BuildContext context, VoidCallback _) {
                        return ProductDetailView(productModel: it,);
                      },
                      closedElevation: 20.0,
                      openElevation: 20,
                      closedShape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(11),
                        ),
                      ),
                      openColor: Colors.transparent,
                      closedColor: Theme.of(context).scaffoldBackgroundColor,
                      closedBuilder: (BuildContext context, VoidCallback openContainer) {
                        return InkWell(
                          onTap: openContainer,
                          child: CatalogCard(
                            productModel: state.products[index],
                            didFavorite: didFavorite,
                            onFavoriteClicked: (int itemId) =>
                                productsBloc.add(OnAddToFavorite(itemId)),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }),
            );
          });
        },
      );
}
