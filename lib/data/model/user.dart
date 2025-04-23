class User {
  final String email;
  final String name;
  final bool? isAdmin;
  final String? address;

  User({
    required this.email,
    required this.name,
    this.isAdmin,
    this.address
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    email: json["email"],
    name: json["name"],
    isAdmin: json["isAdmin"],
    address: json["address"],
  );

  factory User.empty() => User(
      email: '',
      name: '',
  );
}


