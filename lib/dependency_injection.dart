import 'package:flutter_clean_architecture/src/core/database/operations.dart';
import 'package:flutter_clean_architecture/src/core/platform/network_info.dart';
import 'package:flutter_clean_architecture/src/core/utils/input_converter.dart';
import 'package:flutter_clean_architecture/src/features/products/data/datasources/product_local_datasource.dart';
import 'package:flutter_clean_architecture/src/features/products/data/datasources/product_remote_datasource.dart';
import 'package:flutter_clean_architecture/src/features/products/data/repositories/product_repository_impl.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/usecases/get_all_products_usecase.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/usecases/get_product_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:http/http.dart' as http;

GetIt locator = GetIt.instance;

Future dependencyInjection() async {
  //Use cases
  locator.registerLazySingleton(() => GetProductUsecase(repository: locator()));
  locator.registerLazySingleton(
      () => GetAllProductsUsecase(repository: locator()));

  //Repostories
  locator.registerLazySingleton(
    () => ProductRepositoryImpl(
      remoteDatasource: locator(),
      localDatasource: locator(),
      networkInfo: locator(),
    ),
  );

  //Datasources
  locator.registerLazySingleton<ProductRemoteDatasource>(
      () => ProductRemoteDatasourceImpl(client: locator()));
  locator.registerLazySingleton<ProductLocalDatasource>(
      () => ProductLocalDatasourceImpl(database: locator()));

  //Core
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectionChecker: locator(),
    ),
  );

  locator.registerLazySingleton(() => InputConverter());

  //External
  sqfliteFfiInit();
  final databaseFactory = databaseFactoryFfi;
  final db = await databaseFactory.openDatabase(inMemoryDatabasePath);
  await createTables(db);
  locator.registerLazySingleton(() => db);

  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => InternetConnectionChecker.instance);
}
