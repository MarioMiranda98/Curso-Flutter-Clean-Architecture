import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/core/errors/exceptions.dart';

import 'package:flutter_clean_architecture/src/core/errors/failures.dart';
import 'package:flutter_clean_architecture/src/core/platform/network_info.dart';
import 'package:flutter_clean_architecture/src/features/products/data/datasources/product_local_datasource.dart';
import 'package:flutter_clean_architecture/src/features/products/data/datasources/product_remote_datasource.dart';
import 'package:flutter_clean_architecture/src/features/products/data/models/product_model.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/entities/product_entity.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepositoryInterface {
  final ProductRemoteDatasource remoteDatasource;
  final ProductLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failures, ProductEntity>> getProduct(int productId) async {
    if (!await networkInfo.isConnected) {
      try {
        final localProduct = await localDatasource.getProduct(productId);

        return Right(localProduct);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }

    try {
      final remoteProduct = await remoteDatasource.getProduct(productId);

      await localDatasource.saveProduct(remoteProduct);

      return Right(remoteProduct);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failures, List<ProductEntity>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        List<ProductModel> listProductsRemote =
            await remoteDatasource.getProducts();
        return Right(listProductsRemote);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure(message: "Sin conexión a internet"));
    }
  }
}
