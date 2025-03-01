import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/entities/rating_entity.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingEntity rating;

  ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        description,
        category,
        image,
        rating,
      ];
}
