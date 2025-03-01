import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/src/core/errors/failures.dart';
import 'package:flutter_clean_architecture/src/core/usecases/usecases.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/entities/product_entity.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/repositories/product_repository.dart';

class GetAllProductsUsecase implements Usecases<List<ProductEntity>, NoParams> {
  final ProductRepositoryInterface repository;

  GetAllProductsUsecase({required this.repository});

  @override
  Future<Either<Failures, List<ProductEntity>>> call(NoParams params) async =>
      await repository.getProducts();
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
