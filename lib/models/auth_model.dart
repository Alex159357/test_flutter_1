

class AuthModel {
  AuthModel({
    required this.token,
  });
  late final String token;

  AuthModel.fromJson(Map<String, dynamic> json){
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    return _data;
  }
}
