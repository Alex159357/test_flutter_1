import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_flutter_1/bloc/products/products_bloc.dart';
import 'package:test_flutter_1/bloc/products/products_state.dart';
import 'package:test_flutter_1/presentation/widget/search/search_bar.dart';

import '../../../bloc/products/product_screen_state.dart';
import '../../../bloc/products/products_event.dart';
import '../../view/catalog/catalog_view.dart';
import '../../view/catalog/search_view.dart';

late ProductsBloc productsBloc;

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final DraggableScrollableController dragController =
      DraggableScrollableController();

  @override
  void initState() {
    productsBloc = BlocProvider.of<ProductsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productsBloc.add(InitProductEvent());
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: SvgPicture.asset(
            "assets/icons/menu.svg",
              fit: BoxFit.scaleDown
          ),
        ),
        title: _showSearch(),
      ),
      body: Stack(
        children: [const CatalogView(), Positioned.fill(child: _screenStateHandler)],
      ),
      floatingActionButton: _getFab,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget get _getFab => BlocBuilder<ProductsBloc, ProductsState>(builder: (BuildContext context, state) {
    if (state.productListScreenState is InitialProductListScreenState) {
      return FloatingActionButton(
        onPressed: () {},
        child: SvgPicture.asset("assets/icons/sacola.svg"),
      );
    }
    return Container();
  },);

  Widget get _screenStateHandler => BlocBuilder<ProductsBloc, ProductsState>(
        builder: (BuildContext context, state) {
          if (state.productListScreenState is LoadingProductListScreenState) {
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    Text("Loading items. Please wait.")
                  ],
                ),
              ),
            );
          } else if (state.productListScreenState
              is ErrorLoadingProductListScreenState) {
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.warning_amber,
                      color: Theme.of(context).colorScheme.error,
                      size: 80,
                    ),
                    Text((state.productListScreenState
                            as ErrorLoadingProductListScreenState)
                        .message)
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      );

  Widget _showSearch() {
    return OpenContainer<bool>(
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext _, VoidCallback openContainer) {
        return const SearchView();
      },
      onClosed: (b) {
        productsBloc.add(OnSearchValueChanged(""));
      },
      tappable: false,
      transitionDuration: const Duration(milliseconds: 500),
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
      closedElevation: 0.0,
      openColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
      closedColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
      closedBuilder: (BuildContext _, VoidCallback openContainer) {
        return GestureDetector(
          onTap: openContainer,
          child: const SearchBar(),
        );
      },
    );
  }
}
