class OrderMonth {
  int? count;
  int? year;
  int? month;

  OrderMonth({
    this.count,
    this.year,
    this.month,
  });

  factory OrderMonth.fromJson(Map<String, dynamic> json) => OrderMonth(
    count: json["count"],
    year: json["year"],
    month: json["month"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "year": year,
    "month": month,
  };
}
