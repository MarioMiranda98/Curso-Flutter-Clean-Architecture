import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clean_architecture/src/features/products/data/models/rating_model.dart';
import 'package:flutter_clean_architecture/src/features/products/data/models/product_model.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/entities/product_entity.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  final productModelTest = ProductModel(
    id: 1,
    title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
    price: 109.95,
    description:
        "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
    category: "men's clothing",
    image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    rating: RatingModel(
      rate: 3.9,
      count: 120,
    ),
  );

  test('Debe ser una subclase de la entidad Product', () async {
    expect(productModelTest, isA<ProductEntity>());
  });

  group('from json', () {
    test(
        "Deberia devolver un modelo valido cuando el precio JSON es un número entero",
        () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture("product.json"));

      final result = ProductModel.fromJson(jsonMap);

      expect(result, productModelTest);
    });

    test(
        "Deberia devolver un modelo valido cuando el precio JSON es un número double",
        () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture("product_double.json"));

      final result = ProductModel.fromJson(jsonMap);

      expect(result, productModelTest);
    });
  });

  group('to json', () {
    test('Debe devolver un mapa JSON que contenga los datos adecuados',
        () async {
      final result = productModelTest.toJson();

      final expectedMap = {
        "id": 1,
        "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
        "price": 109.95,
        "description":
            "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
        "category": "men's clothing",
        "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
        "rating": {"rate": 3.9, "count": 120}
      };

      expect(result, expectedMap);
    });
  });
}
