import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_flutter_1/bloc/products/products_bloc.dart';
import 'package:test_flutter_1/bloc/products/products_state.dart';
import 'package:test_flutter_1/presentation/sscreen/auth/auth_screen.dart';
import 'package:test_flutter_1/presentation/sscreen/main/main_screen.dart';
import 'package:test_flutter_1/presentation/widget/search/search_bar.dart';

import '../../../bloc/auth/auth_event.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  void initState() {
    productsBloc = BlocProvider.of<ProductsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productsBloc.add(InitProductEvent());
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: GestureDetector(
          onTap:() => _scaffoldKey..currentState!.openDrawer(),
          child: SvgPicture.asset(
            "assets/icons/menu.svg",
              fit: BoxFit.scaleDown
          ),
        ),
        title: _showSearch(),
      ),
      body: Stack(
        children: [const CatalogView()],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                children: [
                  Text('eStore', style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 24, color: Theme.of(context).scaffoldBackgroundColor),),
                  SvgPicture.asset("assets/icons/sacola.svg")
                ],
              ),
            ),
            ListTile(
              title: const Text('My orders'),
              onTap: () {
                Fluttertoast.showToast(msg: "Will be available soon");
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Log out'),
              onTap: () {
                authBloc.add(LogOut());
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: _getFab,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget get _getFab => BlocBuilder<ProductsBloc, ProductsState>(builder: (BuildContext context, state) {
    if (state.productListScreenState is InitialProductListScreenState) {
      return FloatingActionButton(
        onPressed: () {
          Fluttertoast.showToast(msg: "Will be available soon");
        },
        child: SvgPicture.asset("assets/icons/sacola.svg"),
      );
    }
    return Container();
  },);


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
