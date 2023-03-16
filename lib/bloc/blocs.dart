

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_1/bloc/products/products_bloc.dart';

import 'auth/auth_bloc.dart';
import 'auth/auth_event.dart';

class Blocs{

  static Blocs get instance => Blocs();

  final List<BlocProvider> blocList = [
    BlocProvider<AuthBloc>(
      create: (BuildContext context) => AuthBloc()..add(AuthInitEvent()),
    ),
    BlocProvider<ProductsBloc>(
      create: (BuildContext context) => ProductsBloc(),
    ),
  ];

}