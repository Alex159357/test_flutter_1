import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_1/models/product_model.dart';
import 'package:test_flutter_1/presentation/widget/search/search_bar.dart';
import '../../../bloc/products/products_bloc.dart';
import '../../../bloc/products/products_event.dart';
import '../../../bloc/products/products_state.dart';
import '../../sscreen/products/product_screen.dart';
import '../../widget/search/search_item_card.dart';
import '../product/product_detail_view.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [_getSearchBar, Expanded(child: _getProducts)],
        ),
      ),
    );
  }

  Widget get _getSearchBar => BlocBuilder<ProductsBloc, ProductsState>(
          builder: (BuildContext context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SearchBar(
            editable: true,
            initialValue: state.searchReq,
            onChanged: (String value) {
              productsBloc.add(OnSearchValueChanged(value));
            },
            onBackClicked: () => Navigator.pop(context),
          ),
        );
      });

  Widget get _getProducts => BlocBuilder<ProductsBloc, ProductsState>(
        builder: (BuildContext context, state) {
          final mList = state.products
              .where((element) =>
                  element.title
                      .toLowerCase()
                      .contains(state.searchReq.toLowerCase()) ||
                  element.description
                      .toLowerCase()
                      .contains(state.searchReq.toLowerCase()))
              .toList();
          return ListView.builder(
              itemCount: mList.length,
              itemBuilder: (context, i) {
                ProductModel it = mList[i];
                bool didFavorite = state.favariteList.contains(it.id);
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  child: OpenContainer(
                    transitionDuration: const Duration(milliseconds: 700),
                    transitionType: ContainerTransitionType.fade,
                    openBuilder: (BuildContext context, VoidCallback _) {
                      return ProductDetailView(productModel: it,);
                    },
                    closedElevation: 6.0,
                    openElevation: 10,
                    closedShape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    openColor: Colors.transparent,
                    closedColor: Theme.of(context).scaffoldBackgroundColor,
                    closedBuilder: (BuildContext context, VoidCallback openContainer) {
                      return InkWell(
                        onTap: openContainer,
                        child: SearchItemCard(
                          didFavorite: didFavorite,
                          productModel: it,
                          onFavoriteClicked: (int itemId)=> productsBloc.add(OnAddToFavorite(itemId)),
                        ),
                      );
                    },
                  ),
                );
              });
        },
      );
}
