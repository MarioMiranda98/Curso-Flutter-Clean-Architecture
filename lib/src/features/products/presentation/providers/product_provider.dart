import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture/src/core/errors/failures.dart';
import 'package:flutter_clean_architecture/src/core/utils/input_converter.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/entities/product_entity.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/usecases/get_all_products_usecase.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/usecases/get_product_usecase.dart';

class ProductProvider extends ChangeNotifier {
  final GetProductUsecase getProductUsecase;
  final GetAllProductsUsecase getAllProductsUsecase;
  final InputConverter? inputConverter;

  ProductProvider({
    this.inputConverter,
    required this.getProductUsecase,
    required this.getAllProductsUsecase,
  });

  List<ProductEntity> products = <ProductEntity>[];

  Future<Either<String, ProductEntity>> getProduct(String idString) async {
    final Either<Failures, int> inputEither =
        inputConverter!.stringToInt(idString);

    return inputEither.fold(
        (l) => Left(l is InvalidInputFailure
            ? l.message
            : 'No se permiten números negativos'), (r) async {
      final Either<Failures, ProductEntity> usecase =
          await getProductUsecase(Params(id: r));

      return usecase.fold(
          (l) => Left(
              l is ServerFailure ? l.message : (l as CacheFailure).message),
          (product) => Right(product));
    });
  }

  Future<Either<String, List<ProductEntity>>> getProducts() async {
    if (products.isNotEmpty) {
      return Right(products);
    }

    final Either<Failures, List<ProductEntity>> usecase =
        await getAllProductsUsecase(NoParams());

    return usecase.fold(
        (l) => Left(l is ServerFailure
            ? l.message
            : l is CacheFailure
                ? l.message
                : "Error en cache"), (products) {
      this.products = List.from(products);

      return Right(products);
    });
  }
}
