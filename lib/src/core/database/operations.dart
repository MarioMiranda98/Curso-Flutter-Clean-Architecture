import 'package:flutter_clean_architecture/src/features/products/data/models/product_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:flutter_clean_architecture/src/core/database/columns.dart';

//Product table
class TableProduct {
  static Future<void> createTable(Database database) async {
    await database.execute('''
    CREATE TABLE IF NOT EXISTS ${TableProductColumns.table} (
      ${TableProductColumns.id} INTEGER PRIMARY KEY UNIQUE,
      ${TableProductColumns.title} TEXT NOT NULL,
      ${TableProductColumns.price} REAL NOT NULL,
      ${TableProductColumns.category} TEXT NOT NULL,
      ${TableProductColumns.image} TEXT NOT NULL
    )
  ''');
  }

  static Future<void> addProductAndRating(
      Database database, ProductModel product) async {
    await database.transaction((txn) async {
      await txn.insert(TableProductColumns.table, {
        TableProductColumns.id: product.id,
        TableProductColumns.title: product.title,
        TableProductColumns.price: product.price,
        TableProductColumns.description: product.description,
        TableProductColumns.category: product.category,
        TableProductColumns.image: product.image,
      });

      await txn.insert(TableRatingColumns.table, {
        TableRatingColumns.id: product.id,
        TableRatingColumns.rate: product.rating.rate,
        TableRatingColumns.count: product.rating.count,
      });
    });
  }

  static Future<List<Map<String, dynamic>>> getProduct(
      Database database, int productId) async {
    return await database.rawQuery('''
      SELECT * FROM ${TableProductColumns.table} JOIN ${TableRatingColumns.table} 
      ON ${TableRatingColumns.table}.${TableRatingColumns.id} = ${TableProductColumns.table}.${TableProductColumns.id}
      WHERE ${TableProductColumns.table}.${TableProductColumns.id} = ?
    ''', [productId]);
  }

  static Future<List<Map<String, dynamic>>> getProducts(
      Database database) async {
    return await database.rawQuery('''
      SELECT * FROM ${TableProductColumns.table} JOIN ${TableRatingColumns.table} 
      ON ${TableRatingColumns.table}.${TableRatingColumns.id} = ${TableProductColumns.table}.${TableProductColumns.id}
    ''');
  }
}

//Rating table
class TableRating {
  static Future<void> createTable(Database database) async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS ${TableRatingColumns.table} (
        ${TableRatingColumns.id} INTEGER PRIMARY KEY UNIQUE,
        ${TableRatingColumns.rate} REAL,
        ${TableRatingColumns.count} INTEGER,
        FOREIGN KEY (${TableRatingColumns.id}) REFERENCES ${TableProductColumns.table}(${TableProductColumns.id})      
      )
    ''');
  }
}

Future<void> createTables(Database database) async {
  await TableProduct.createTable(database);
  await TableRating.createTable(database);
}
