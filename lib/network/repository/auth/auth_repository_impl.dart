import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_flutter_1/consts/api_values.dart';
import 'package:test_flutter_1/models/auth_model.dart';

import '../../../helpers/prefs_helper.dart';
import '../../client/client.dart';
import '../../client/client_impl.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl extends PrefsHelper implements AuthRepository {
  @override
  Future<AuthModel?> tryAuth(
      {required String username, required String password, Function(String e)? onError}) async {
    Client client = ClientImpl.getInstance<AuthModel>();
    Map<String, dynamic> req = {"username": username, "password": password};
      var response = await client.postData(data: req, apiValues: ApiValues.LOGIN);
      if(response is AuthModel) {
        // setUsername(username);
        // setPassword(password);
        // setToken(response!.token);
        return response;
      }else if(response is String){
        onError?.call(response);
      }
      return null;

  }
}
