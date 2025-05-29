class RevenueCategory {
  int? totalRevenue;
  String? category;

  RevenueCategory({
    this.totalRevenue,
    this.category,
  });

  factory RevenueCategory.fromJson(Map<String, dynamic> json) => RevenueCategory(
    totalRevenue: json["totalRevenue"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "totalRevenue": totalRevenue,
    "category": category,
  };
}
