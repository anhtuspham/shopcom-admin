class RevenueMonth {
  double? totalRevenue;
  int? year;
  int? month;

  RevenueMonth({
    this.totalRevenue,
    this.year,
    this.month,
  });

  factory RevenueMonth.fromJson(Map<String, dynamic> json) => RevenueMonth(
    totalRevenue: json["totalRevenue"]?.toDouble(),
    year: json["year"],
    month: json["month"],
  );

  Map<String, dynamic> toJson() => {
    "totalRevenue": totalRevenue,
    "year": year,
    "month": month,
  };
}
