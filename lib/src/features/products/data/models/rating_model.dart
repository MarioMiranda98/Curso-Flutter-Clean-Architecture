import 'dart:convert';

import 'package:flutter_clean_architecture/src/features/products/domain/entities/rating_entity.dart';

class RatingModel extends RatingEntity {
  final double rate;
  final int count;

  RatingModel({
    required this.rate,
    required this.count,
  }) : super(count: count, rate: rate);

  factory RatingModel.fromRawJson(String str) =>
      RatingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}
