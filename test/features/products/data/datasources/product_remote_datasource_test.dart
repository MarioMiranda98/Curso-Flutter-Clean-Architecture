import 'dart:convert';
import 'dart:io';
import 'package:flutter_clean_architecture/src/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture/src/features/products/data/datasources/product_remote_datasource.dart';
import 'package:flutter_clean_architecture/src/features/products/data/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture_reader.dart';
import 'product_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  late ProductRemoteDatasourceImpl datasourceImpl;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    datasourceImpl = ProductRemoteDatasourceImpl(client: mockClient);
  });

  group("get product", () {
    const testIdProduct = 1;
    final testProductModel =
        ProductModel.fromJson(json.decode(fixture("product.json")));

    test(
        "Debe realizar una solicitud GET en una URL con el id del producto y con el encabezado application/json",
        () async {
      when(mockClient.get(any, headers: anyNamed("headers"))).thenAnswer(
        (realInvocation) async => http.Response(
          fixture("product.json"),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
        ),
      );

      datasourceImpl.getProduct(testIdProduct);

      final url = Uri.https('fakestoreapi.com', '/products/$testIdProduct');

      verify(await mockClient
          .get(url, headers: {"Content-Type": "application/json"}));
    });

    test(
        "Deberida devolver el product model cuandop el codigo de respuesta sea exitoso",
        () async {
      when(mockClient.get(any, headers: anyNamed("headers"))).thenAnswer(
        (realInvocation) async => http.Response(
          fixture("product.json"),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
        ),
      );

      final result = await datasourceImpl.getProduct(testIdProduct);
      expect(result, equals(testProductModel));
    });

    test(
        "Debería lanzar un ServerException cuando el código de respuesta sea 404 u otro",
        () async {
      when(mockClient.get(any, headers: anyNamed("headers"))).thenAnswer(
          (realInvocation) async => http.Response("Oops, Algo salió mal", 404));

      final call = datasourceImpl.getProduct;
      expect(() => call(testIdProduct),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group(
    "get products",
    () {
      final jsonProducts = List.from(json.decode(fixture("products.json")));
      final testProducts =
          jsonProducts.map((jsonProduct) => ProductModel.fromJson(jsonProduct));

      test(
        "Debe realizar una solicitud GET en una URL con el id del producto y con el encabezado application/json",
        () async {
          when(mockClient.get(any, headers: anyNamed("headers"))).thenAnswer(
            (realInvocation) async => http.Response(
              fixture("products.json"),
              200,
              headers: {
                HttpHeaders.contentTypeHeader: "appliction/json; charset=utf-8"
              },
            ),
          );

          datasourceImpl.getProducts();

          final url = Uri.https("fakestoreapi.com", "/products");

          verify(await mockClient
              .get(url, headers: {"Content-Type": "application/json"}));
        },
      );

      test(
        "Debería devolver una lista de productModel cuando el código de respuesta sea exitoso",
        () async {
          when(mockClient.get(any, headers: anyNamed("headers"))).thenAnswer(
            (realInvocation) async => http.Response(
                fixture("products.json"), 200,
                headers: {"Content-Type": "application/json; charset=utf-8"}),
          );

          final result = await datasourceImpl.getProducts();

          expect(result, equals(testProducts));
        },
      );

      test(
        "Debería lanzar un ServerException cuando el código de respuesta sea 404 u otro",
        () async {
          when(mockClient.get(any, headers: anyNamed("headers"))).thenAnswer(
              (realInvocation) async =>
                  http.Response("Oops, Algo salió mal", 404));

          final call = datasourceImpl.getProducts;
          expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
        },
      );
    },
  );
}
