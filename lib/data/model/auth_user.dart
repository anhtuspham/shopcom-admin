class AuthUser {
  String name = "";
  String email = "";
  // bool isVerifiedEmail = false;
  // bool isForgotPassword = false;
  bool isAdmin = false;
  String token = "";
  AuthUser();

  AuthUser.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    token = json['token'] ?? "";
    email = json['email'] ?? "";
    // isVerifiedEmail = json['isVerifiedEmail'] ?? false;
    // isForgotPassword = json['isForgotPassword'] ?? false;
    isAdmin = json['isAdmin'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['token'] = token;
    data['email'] = email;
    data['isAdmin'] = isAdmin;
    return data;
  }
}