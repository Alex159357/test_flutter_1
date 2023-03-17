import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_1/bloc/auth/user_auth_state.dart';
import 'package:test_flutter_1/models/auth_model.dart';
import 'package:test_flutter_1/presentation/sscreen/main/main_screen.dart';
import '../../helpers/prefs_helper.dart';
import '../../network/repository/auth/auth_repository.dart';
import '../../network/repository/auth/auth_repository_impl.dart';
import 'auth_event.dart';
import 'auth_screen_state.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = AuthRepositoryImpl();
  final PrefsHelper _prefsHelper = PrefsHelper();

  AuthBloc() : super(AuthState()) {
    on<AuthInitEvent>(_init);
    on<OnAuthClicked>(_onAuthClicked);
    on<OnPasswordSecureChanged>(_onPasswordSecureChanged);
    on<OnPasswordChanged>(_onPasswordChanged);
    on<OnUsernameChanged>(_onUsernameChanged);
    on<LogOut>(_logOut);
  }

  void _init(AuthInitEvent event, Emitter<AuthState> emit) async {
    if(_prefsHelper.getUsername != null && _prefsHelper.getPassword != null){
      try{
        AuthModel? authModel = await _authRepository.tryAuth(username: _prefsHelper.getUsername!, password: _prefsHelper.getPassword!);
        if(authModel != null){
          emit(state.clone(userAuthState: AuthenticatedUserState()));
          navCubit.productScreen();
          overScreensCubit.hideLoading();
        }else{
          emit(state.clone(userAuthState: const UnAuthenticatedUserState() ));
          overScreensCubit.hideLoading();
        }
      }catch(e){
        if (kDebugMode) {
          print("AuthError-> $e");
        }
        overScreensCubit.hideLoading();
        emit(state.clone(authScreenState: const InitialAuthScreenState(), userAuthState: const UnAuthenticatedUserState() ));
      }
    }else{
      overScreensCubit.hideLoading();
      emit(state.clone(authScreenState: const InitialAuthScreenState(), userAuthState: const UnAuthenticatedUserState() ));
    }
  }

  FutureOr<void> _onAuthClicked(OnAuthClicked event, Emitter<AuthState> emit) async {
    overScreensCubit.showLoading();
    emit(state.clone(authErrorMessage: ""));
      dynamic authModel = await _authRepository.tryAuth(username: state.username, password: state.password, onError: (v){
        emit(state.clone(authErrorMessage: v));
      });
      if(authModel != null && authModel is AuthModel){
        navCubit.productScreen();
        emit(state.clone(userAuthState: AuthenticatedUserState()));
      }else{
        overScreensCubit.hideLoading();
        emit(state.clone(userAuthState: const UnAuthenticatedUserState() ));
      }
  }

  FutureOr<void> _onPasswordSecureChanged(OnPasswordSecureChanged event, Emitter<AuthState> emit) {
    emit(state.clone(passwordSecureState: !state.passwordSecureState));
  }

  FutureOr<void> _onPasswordChanged(OnPasswordChanged event, Emitter<AuthState> emit) {
    emit(state.clone(password: event.password,  authErrorMessage: ""));
  }

  FutureOr<void> _onUsernameChanged(OnUsernameChanged event, Emitter<AuthState> emit) {
    emit(state.clone(username: event.username, authErrorMessage: ""));
  }

  FutureOr<void> _logOut(LogOut event, Emitter<AuthState> emit) {
    _prefsHelper.clearPrefs();
    navCubit.authScreen();
  }

}
