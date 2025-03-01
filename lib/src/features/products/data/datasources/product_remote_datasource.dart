import 'dart:convert';

import 'package:flutter_clean_architecture/src/core/errors/exceptions.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_clean_architecture/src/features/products/data/models/product_model.dart';

abstract class ProductRemoteDatasource {
  Future<ProductModel> getProduct(int productId);

  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  final http.Client client;

  ProductRemoteDatasourceImpl({
    required this.client,
  });

  @override
  Future<ProductModel> getProduct(int productId) async {
    try {
      final url = Uri.https('fakestoreapi.com', '/products/$productId');
      final result =
          await client.get(url, headers: {"Content-Type": "application/json"});

      final jsonProduct = json.decode(result.body);

      return ProductModel.fromJson(jsonProduct);
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final url = Uri.https('fakestoreapi.com', '/products');
      final result =
          await client.get(url, headers: {"Content-Type": "application/json"});

      final productsList = List.from(json.decode(result.body));

      final products = productsList
          .map((product) => ProductModel.fromJson(product))
          .toList();

      return products;
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
