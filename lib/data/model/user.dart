class User {
  final String? id;
  final String email;
  final String name;
  final bool? isAdmin;
  final String? address;

  User(
      {this.id,
      required this.email,
      required this.name,
      this.isAdmin,
      this.address});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        isAdmin: json["isAdmin"],
        address: json["address"],
      );

  factory User.empty() => User(
        email: '',
        name: '',
      );

  Map<String, dynamic> toJson() => {
        "Email": email,
        "Name": name,
        "isAdmin": isAdmin,
        "Address": address,
      };
}
