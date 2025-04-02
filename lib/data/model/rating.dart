import 'dart:convert';

class Ratings {
  double? average;
  int? count;

  Ratings({
    this.average,
    this.count,
  });

  factory Ratings.fromRawJson(String str) => Ratings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ratings.fromJson(Map<String, dynamic> json) => Ratings(
    average: json["average"].toDouble(),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "average": average,
    "count": count,
  };
}