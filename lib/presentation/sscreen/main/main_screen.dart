import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_flutter_1/bloc/auth/auth_bloc.dart';
import 'package:test_flutter_1/bloc/auth/auth_state.dart';
import 'package:test_flutter_1/network/repository/auth/auth_repository.dart';
import 'package:test_flutter_1/network/repository/auth/auth_repository_impl.dart';

import '../../../bloc/auth/user_auth_state.dart';
import '../../../bloc/over_screens/over_screens_cubit.dart';
import '../../../bloc/over_screens/over_screens_state.dart';
import '../../../bloc/screen_state/screen_state_cubit.dart';
import '../../../bloc/screen_state/screen_state_state.dart';
import '../../view/auth/auth_view.dart';
import '../auth/auth_screen.dart';
import '../products/product_screen.dart';

late ScreenStateCubit navCubit;
late OverScreensCubit overScreensCubit;

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
    navCubit = BlocProvider.of<ScreenStateCubit>(context);
    overScreensCubit = BlocProvider.of<OverScreensCubit>(context);
    return Stack(
      children: [
        _body,
        Positioned.fill(child: _screenState)
      ],
    );
  }


  Widget get _body => BlocBuilder<ScreenStateCubit, ScreenStateState>(builder: (BuildContext context, state) {
    if(state is ProductScreenNavState){
      return const ProductScreen();
    }else if(state is AuthScreenNavState){
      return const AuthScreen();
    }else {
      return  const AuthScreen();
    }
  },);

  Widget get _screenState=> BlocBuilder<OverScreensCubit, OverScreensState>(builder: (BuildContext context, state) {
    if(state is LoadingScreen){
      return Container(color: Theme.of(context).scaffoldBackgroundColor, child: const Center(child: SizedBox(width: 50, height: 50, child: CircularProgressIndicator()),),);
    }else if(state is ErrorScreen){
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
        children: [
          Icon(Icons.warning_amber, size: 80, color: Theme.of(context).colorScheme.error,),
          Text(state.message),
        ],
      ),);
    }else{
      return Container();
    }
  });

}
