

import '../../../models/auth_model.dart';

abstract class AuthRepository{

  Future<AuthModel?> tryAuth({required String username, required String password});

}