import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_flutter_1/bloc/auth/auth_bloc.dart';
import 'package:test_flutter_1/bloc/auth/auth_state.dart';
import 'package:test_flutter_1/presentation/decorations/decorations.dart';
import 'package:test_flutter_1/presentation/sscreen/auth/auth_screen.dart';

import '../../../bloc/auth/auth_event.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "eComerce",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            _getErrorMessage,
            _usernameField,
            _passwordField,
            _getForgetButton,
            _getLoginButton
          ],
        ),
      ),
    );
  }

  Widget get _getErrorMessage =>
      BlocBuilder<AuthBloc, AuthState>(builder: (BuildContext context, state) {
        return state.authErrorMessage.isNotEmpty
            ? Center(child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(state.authErrorMessage, style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.error),),
            ))
            : Container();
      });

  Widget get _usernameField => BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: 32,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: SizedBox(
                    height: 30,
                    child: TextFormField(
                      initialValue: state.username,
                      onChanged: (v) => authBloc.add(OnUsernameChanged(v)),
                      decoration: Decorations.instance.authTextFieldDecoration
                          .copyWith(
                              fillColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              hintText: "User name",
                              hintStyle: Theme.of(context).textTheme.bodySmall),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );

  Widget get _passwordField => BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Positioned(
                      child: Container(
                        height: 32,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: SizedBox(
                        height: 30,
                        child: TextFormField(
                          initialValue: state.password,
                          obscureText: state.passwordSecureState,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (v) => authBloc.add(OnPasswordChanged(v)),
                          decoration: Decorations
                              .instance.authTextFieldDecoration
                              .copyWith(
                                  fillColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  hintText: "Password",
                                  hintStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                  suffixIcon: GestureDetector(
                                    onTap: () =>
                                        authBloc.add(OnPasswordSecureChanged()),
                                    child: SvgPicture.asset(
                                        state.passwordSecureState
                                            ? "assets/icons/eye_crossed.svg"
                                            : "assets/icons/eye.svg",
                                        width: 14,
                                        height: 14,
                                        fit: BoxFit.scaleDown),
                                  )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );

  Widget get _getForgetButton => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(onPressed: () {}, child: Text("Forgot password")),
          ),
        ],
      );

  Widget get _getLoginButton => BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
            child: ElevatedButton(
                onPressed: () => authBloc.add(OnAuthClicked()),
                child: Text(
                  "Log In",
                  style: Theme.of(context).textTheme.labelLarge,
                )),
          );
        },
      );
}
