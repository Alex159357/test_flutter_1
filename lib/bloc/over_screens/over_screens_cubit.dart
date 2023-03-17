import 'package:bloc/bloc.dart';

import 'over_screens_state.dart';

class OverScreensCubit extends Cubit<OverScreensState> {
  OverScreensCubit() : super(LoadingScreen());

  void showLoading() => emit(LoadingScreen());
  void hideLoading() => emit(InitialScreen());
  void showError(String message) => emit(ErrorScreen(message));

}
