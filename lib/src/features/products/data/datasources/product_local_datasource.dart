import 'package:flutter_clean_architecture/src/core/database/operations.dart';
import 'package:flutter_clean_architecture/src/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture/src/features/products/data/models/product_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

abstract class ProductLocalDatasource {
  Future<ProductModel> getProduct(int productId);

  Future<List<ProductModel>> getProducts();

  Future<void> saveProduct(ProductModel productModel);
}

class ProductLocalDatasourceImpl implements ProductLocalDatasource {
  late Database database;

  ProductLocalDatasourceImpl({
    required this.database,
  });

  @override
  Future<ProductModel> getProduct(int productId) async {
    final result = await TableProduct.getProduct(database, productId);

    if (result.isEmpty) {
      throw CacheException(message: "Error en caché");
    }

    final productJson = List.from(result);

    Map<String, dynamic> product = Map.from(productJson.first);

    Map<String, dynamic> ratingMap = {
      "rate": product["rate"],
      "count": product["count"]
    };

    product.remove("rate");
    product.remove("count");

    product["rating"] = ratingMap;

    return ProductModel.fromJson(product);
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      List<ProductModel> products = List.empty(growable: true);
      final result = await TableProduct.getProducts(database);

      if (result.isEmpty) {
        throw CacheException(message: "Error en caché");
      }

      final productJson = List.from(result);

      for (final product in productJson) {
        Map<String, dynamic> p = Map.from(product);

        Map<String, dynamic> ratingMap = {
          "rate": product["rate"],
          "count": product["count"]
        };

        p.remove("rate");
        p.remove("count");

        p["rating"] = ratingMap;

        products.add(ProductModel.fromJson(product));
      }

      return products;
    } on Exception catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> saveProduct(ProductModel productModel) async {
    try {
      await TableProduct.addProductAndRating(database, productModel);
    } on Exception catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
