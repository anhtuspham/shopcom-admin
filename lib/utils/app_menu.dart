class MenuItem {
  String code = "";
  String name = "";
  String type = "";
  String role = "";
  List<MenuChildItem> children = [];

  MenuItem({required this.code, required this.name, required this.type, required this.children, required this.role});

  MenuItem.fromJson(Map<String, dynamic> json) {
    code = json['code'] ?? "";
    name = json['name'] ?? "";
    type = json['type'] ?? "";
    role = json['role'] ?? "";
    if (json['children'] != null) {
      children = <MenuChildItem>[];
      json['children'].forEach((v) {
        children.add(MenuChildItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    data['type'] = type;
    data['role'] = role;
    data['children'] = children.map((v) => v.toJson()).toList();
    return data;
  }
}

class MenuChildItem {
  String code = "";
  String name = "";

  MenuChildItem({required this.code, required this.name});

  MenuChildItem.fromJson(Map<String, dynamic> json) {
    code = json['code'] ?? "";
    name = json['name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}

final List<MenuItem> default_app_menu = [
  // MenuItem(code: "home", name: "Home", type: "base", role: 'admin, manager, dev', children: []),
  MenuItem(code: "home", name: "home", type: "base", role: 'admin, manager, dev', children: []),
  MenuItem(code: "userPage", name: "user", type: "base", role: 'admin, manager', children: []),
];