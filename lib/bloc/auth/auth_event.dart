abstract class AuthEvent {}

class AuthInitEvent extends AuthEvent {}

class OnAuthClicked extends AuthEvent{}

class OnPasswordSecureChanged extends AuthEvent{}

class OnPasswordChanged extends AuthEvent{
  final String password;

  OnPasswordChanged(this.password);
}

class OnUsernameChanged extends AuthEvent{
  final String username;

  OnUsernameChanged(this.username);
}