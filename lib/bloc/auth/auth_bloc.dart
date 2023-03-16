import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:test_flutter_1/bloc/auth/user_auth_state.dart';
import 'package:test_flutter_1/models/auth_model.dart';
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
  }

  void _init(AuthInitEvent event, Emitter<AuthState> emit) async {
    if(_prefsHelper.getUsername != null && _prefsHelper.getPassword != null){
      emit(state.clone(authScreenState: LoadingAuthScreenState()));
       AuthModel? authModel = await _authRepository.tryAuth(username: _prefsHelper.getUsername!, password: _prefsHelper.getPassword!);
       if(authModel != null){
         emit(state.clone(authScreenState: const InitialAuthScreenState(), userAuthState: AuthenticatedUserState()));
       }
    }else{
      emit(state.clone(authScreenState: const InitialAuthScreenState(), userAuthState: UnAuthenticatedUserState() ));
    }
  }

  FutureOr<void> _onAuthClicked(OnAuthClicked event, Emitter<AuthState> emit) async {
    emit(state.clone(authScreenState: LoadingAuthScreenState()));
    AuthModel? authModel = await _authRepository.tryAuth(username: state.username, password: state.password);
    print("AuthState ${authModel}");
    if(authModel != null){
      emit(state.clone(authScreenState: const InitialAuthScreenState(), userAuthState: AuthenticatedUserState()));
    }
  }

  FutureOr<void> _onPasswordSecureChanged(OnPasswordSecureChanged event, Emitter<AuthState> emit) {
    print("PASSWORD SECURE");
    emit(state.clone(passwordSecureState: !state.passwordSecureState));
  }

  FutureOr<void> _onPasswordChanged(OnPasswordChanged event, Emitter<AuthState> emit) {
    emit(state.clone(password: event.password));
  }

  FutureOr<void> _onUsernameChanged(OnUsernameChanged event, Emitter<AuthState> emit) {
    emit(state.clone(username: event.username));
  }
}
