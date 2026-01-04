class UserModel {
  User? user;
  String? accessToken;
  UserModel({this.user, this.accessToken});
  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    accessToken = json['accessToken'];
  }
}

class User {
  String? id;
  String? email;
  bool? isEmailVerified;

  User({this.id, this.email, this.isEmailVerified});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['isEmailVerified'] = isEmailVerified;
    return data;
  }
}
