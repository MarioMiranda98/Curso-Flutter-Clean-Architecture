import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/core/errors/failures.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/entities/product_entity.dart';

abstract class ProductRepositoryInterface {
  Future<Either<Failures, ProductEntity>> getProduct(int productId);

  Future<Either<Failures, List<ProductEntity>>> getProducts();
}
