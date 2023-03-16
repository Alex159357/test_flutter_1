

abstract class UserAuthState{

  const UserAuthState();
}

class UnAuthenticatedUserState extends UserAuthState{

  const UnAuthenticatedUserState();
}

class AuthenticatedUserState extends UserAuthState{}