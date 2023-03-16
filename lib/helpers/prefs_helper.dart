

import '../main.dart';

class PrefsHelper{
  String? get getUsername => prefs.getString("username");
  String? get getPassword => prefs.getString("password");
  String? get getToken => prefs.getString("token");

  void setUsername(String username){
    prefs.setString("username", username);
  }
  void setPassword(String password){
    prefs.setString("username", password);
  }

  void setToken(String token){
    prefs.setString("token", token);
  }


}