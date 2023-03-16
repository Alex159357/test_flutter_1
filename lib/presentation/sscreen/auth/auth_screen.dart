

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_1/bloc/auth/auth_state.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/auth/auth_screen_state.dart';
import '../../view/auth/auth_view.dart';

late AuthBloc authBloc;

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
      ),
      body: Stack(
        children: [
          const SafeArea(child: AuthView()),
          Positioned.fill(child: _getLoadingView)
        ],
      ),
    );
  }

  Widget get _getLoadingView => BlocBuilder<AuthBloc, AuthState>(builder: (BuildContext context, state) {
    if(state.authScreenState is LoadingAuthScreenState){
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
    }
    return Container();
  },);

}
