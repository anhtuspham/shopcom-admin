class AuthUser {
  String name = "";
  String email = "";
  bool isVerifiedEmail = false;
  bool isForgotPassword = false;
  bool isAdmin = false;
  String token = "";

  AuthUser.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    token = json['token'] ?? "";
    email = json['email'] ?? "";
    isVerifiedEmail = json['isVerifiedEmail'] ?? false;
    isForgotPassword = json['isForgotPassword'] ?? false;
    isAdmin = json['isAdmin'] ?? false;
  }
}