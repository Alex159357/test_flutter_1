import 'package:bloc/bloc.dart';

import 'screen_state_state.dart';

class ScreenStateCubit extends Cubit<ScreenStateState> {
  ScreenStateCubit() : super(AuthScreenNavState());

  void initialScreen()=> emit(InitialNavState());
  void authScreen()=> emit(AuthScreenNavState());
  void productScreen()=> emit(ProductScreenNavState());

}
