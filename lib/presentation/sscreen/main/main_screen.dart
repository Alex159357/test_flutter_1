import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_1/bloc/auth/auth_bloc.dart';
import 'package:test_flutter_1/bloc/auth/auth_state.dart';
import 'package:test_flutter_1/network/repository/auth/auth_repository.dart';
import 'package:test_flutter_1/network/repository/auth/auth_repository_impl.dart';

import '../../../bloc/auth/user_auth_state.dart';
import '../../view/auth/auth_view.dart';
import '../auth/auth_screen.dart';
import '../products/product_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _body;
  }


  Widget get _body => BlocBuilder<AuthBloc, AuthState>(builder: (BuildContext context, state) {
    // print("AuthState ${state.userAuthState.runtimeType}");
    if(state.userAuthState is AuthenticatedUserState){
      return const ProductScreen();
    }else {
      return const AuthScreen();
    }
  },);

}
