import 'dart:convert';

import 'package:flutter_clean_architecture/src/core/database/columns.dart';
import 'package:flutter_clean_architecture/src/core/database/operations.dart';
import 'package:flutter_clean_architecture/src/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture/src/features/products/data/datasources/product_local_datasource.dart';
import 'package:flutter_clean_architecture/src/features/products/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  late ProductLocalDatasourceImpl datasourceImpl;
  late Database database;

  setUp(() async {
    sqfliteFfiInit();

    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

    await createTables(database);

    datasourceImpl = ProductLocalDatasourceImpl(database: database);
  });

  test(
      'Debe retornar un objeto ProductModel desde Sqflite si esta almacenado en cache',
      () async {
    const productId = 9;

    //Obtener el json de producto
    final cachedProductJson =
        List.from(json.decode(fixture("product_cached.json")));

    //Definir el product model

    final ProductModel expectedProduct =
        ProductModel.fromJson(cachedProductJson.elementAt(0));

    //Guardar el producto
    await TableProduct.addProductAndRating(database, expectedProduct);

    //Llamar al metodo get product
    final result = await datasourceImpl.getProduct(productId);

    expect(result, equals(expectedProduct));
  });

  test('Debería devolver un error cuando no hay un valor en caché', () async {
    await database.execute('''DELETE FROM ${TableProductColumns.table}''');
    await database.execute('''DELETE FROM ${TableRatingColumns.table}''');

    const productId = 9;

    final call = datasourceImpl.getProduct;

    expect(() => call(productId), throwsA(const TypeMatcher<CacheException>()));
  });

  test('Deberia llamar a save product correctamente sin lanzar excepciones',
      () async {
    ProductModel productModel = ProductModel.fromJson(const {
      "id": 9,
      "title": "WD 2TB Elements Portable External Hard Drive - USB 3.0 ",
      "price": 64.0,
      "description":
          "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system",
      "category": "electronics",
      "image": "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg",
      "rating": {"rate": 3.3, "count": 203}
    });

    datasourceImpl.saveProduct(productModel);

    await expectLater(datasourceImpl.saveProduct(productModel), completes);
  });
}
