import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
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

  final List<ProductEntity> product = <ProductEntity>[];

  Future<Either<String, ProductEntity>> getProduct(String idString) async {
    throw UnimplementedError();
  }

  Future<Either<String, List<ProductEntity>>> getProducts() async {
    throw UnimplementedError();
  }
}
