import 'package:test_flutter_1/bloc/auth/user_auth_state.dart';

import 'auth_screen_state.dart';

class AuthState {
  final String username;
  final String password;
  final UserAuthState userAuthState;
  final bool passwordSecureState;
  final String authErrorMessage;

  bool get loginButtonState => password.length >= 6 && username.length > 4;

  AuthState(
      {
      this.username = "mor_2314",
      this.password = "83r5^_",
      this.userAuthState = const UnAuthenticatedUserState(),
      this.passwordSecureState = true,
      this.authErrorMessage = ""});

  AuthState clone(
          {AuthScreenState? authScreenState,
          String? username,
          String? password,
          UserAuthState? userAuthState,
          bool? passwordSecureState,
          String? authErrorMessage}) =>
      AuthState(
          username: username ?? this.username,
          password: password ?? this.password,
          userAuthState: userAuthState ?? this.userAuthState,
          passwordSecureState: passwordSecureState ?? this.passwordSecureState,
          authErrorMessage: authErrorMessage ?? this.authErrorMessage);
}
