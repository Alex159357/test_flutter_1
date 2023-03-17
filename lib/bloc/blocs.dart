

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_1/bloc/products/products_bloc.dart';
import 'package:test_flutter_1/bloc/screen_state/screen_state_cubit.dart';

import 'auth/auth_bloc.dart';
import 'auth/auth_event.dart';
import 'over_screens/over_screens_cubit.dart';

class Blocs{

  static Blocs get instance => Blocs();

  final List<BlocProvider> blocList = [
    BlocProvider<OverScreensCubit>(
      create: (BuildContext context) => OverScreensCubit(),
    ),
    BlocProvider<AuthBloc>(
      create: (BuildContext context) => AuthBloc()..add(AuthInitEvent()),
    ),
    BlocProvider<ScreenStateCubit>(
      create: (BuildContext context) => ScreenStateCubit(),
    ),
    BlocProvider<ProductsBloc>(
      create: (BuildContext context) => ProductsBloc(),
    ),
  ];

}