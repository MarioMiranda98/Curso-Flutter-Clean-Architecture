import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/src/core/errors/failures.dart';
import 'package:flutter_clean_architecture/src/core/usecases/usecases.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/entities/product_entity.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/repositories/product_repository.dart';

class GetProductUsecase implements Usecases<ProductEntity, Params> {
  final ProductRepositoryInterface repository;

  GetProductUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failures, ProductEntity>> call(Params params) async =>
      await repository.getProduct(params.id);
}

class Params extends Equatable {
  final int id;

  Params({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
