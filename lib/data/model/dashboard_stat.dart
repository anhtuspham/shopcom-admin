class DashboardStat {
  double totalRevenue;
  int totalOrders;
  int totalUsers;
  int totalProducts;

  DashboardStat({
    required this.totalRevenue,
    required this.totalOrders,
    required this.totalUsers,
    required this.totalProducts,
  });

  factory DashboardStat.fromJson(Map<String, dynamic> json) => DashboardStat(
    totalRevenue: json["totalRevenue"]?.toDouble(),
    totalOrders: json["totalOrders"],
    totalUsers: json["totalUsers"],
    totalProducts: json["totalProducts"],
  );

  Map<String, dynamic> toJson() => {
    "totalRevenue": totalRevenue,
    "totalOrders": totalOrders,
    "totalUsers": totalUsers,
    "totalProducts": totalProducts,
  };
}