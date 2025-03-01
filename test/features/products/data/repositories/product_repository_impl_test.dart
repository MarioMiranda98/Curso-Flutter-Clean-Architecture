import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture/src/core/errors/failures.dart';
import 'package:flutter_clean_architecture/src/core/platform/network_info.dart';
import 'package:flutter_clean_architecture/src/features/products/data/datasources/product_local_datasource.dart';
import 'package:flutter_clean_architecture/src/features/products/data/datasources/product_remote_datasource.dart';
import 'package:flutter_clean_architecture/src/features/products/data/models/product_model.dart';
import 'package:flutter_clean_architecture/src/features/products/data/models/rating_model.dart';
import 'package:flutter_clean_architecture/src/features/products/data/repositories/product_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ProductRemoteDatasource>(),
  MockSpec<ProductLocalDatasource>(),
  MockSpec<NetworkInfo>(),
])
void main() {
  late ProductRepositoryImpl repositoryImpl;
  late MockProductRemoteDatasource mockProductRemoteDatasource;
  late MockProductLocalDatasource mockProductLocalDatasource;
  late MockNetworkInfo mockNetworkInfo;

  ProductModel productModelTest = ProductModel(
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

  setUp(() {
    mockProductRemoteDatasource = MockProductRemoteDatasource();
    mockProductLocalDatasource = MockProductLocalDatasource();
    mockNetworkInfo = MockNetworkInfo();

    repositoryImpl = ProductRepositoryImpl(
      remoteDatasource: mockProductRemoteDatasource,
      localDatasource: mockProductLocalDatasource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('Obtener producto invidual', () {
    const productId = 9;

    test('Comprobar si se esta verificando que el dispositivo este en linea',
        () async {
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);

      repositoryImpl.getProduct(productId);
      verify(mockNetworkInfo.isConnected);
    });
  });

  group('El dispositivo esta en linea', () async {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test(
        "Devolver los datos remotos cuando la llamada a la fuente remota sea exitosa.",
        () async {
      when(mockProductRemoteDatasource.getProduct(any))
          .thenAnswer((_) async => productModelTest);

      final result = await repositoryImpl.getProduct(1);

      verify(mockProductRemoteDatasource.getProduct(1));
      expect(result, equals(Right(productModelTest)));
    });

    test('Debe almacenar los datos localmente', () async {
      when(mockProductRemoteDatasource.getProduct(any))
          .thenAnswer((_) async => productModelTest);

      await repositoryImpl.getProduct(1);
      verify(mockProductRemoteDatasource.getProduct(1));
      verify(mockProductLocalDatasource.saveProduct(productModelTest));
    });

    test(
        "Devolver error del servidor cuando la llamada a la fuente remota no es exitosa",
        () async {
      when(mockProductRemoteDatasource.getProduct(any))
          .thenThrow(ServerException(message: "Error de servidor"));

      final result = await repositoryImpl.getProduct(1);
      verify(mockProductRemoteDatasource.getProduct(1));
      verifyZeroInteractions(mockProductLocalDatasource);
      expect(result, Left(ServerFailure(message: "Error de servidor")));
    });
  });

  group("El dispositivo no esta en línea", () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });

    test(
        "Devolver los datos almacenados en cache localmente cuando los datos estén presentes",
        () async {
      when(mockProductLocalDatasource.getProduct(any))
          .thenAnswer((realInvocation) async => productModelTest);

      final result = await repositoryImpl.getProduct(1);
      verifyZeroInteractions(mockProductRemoteDatasource);
      verify(mockProductLocalDatasource.getProduct(1));
      expect(result, equals(productModelTest));
    });

    test("Devolver cache failure cuando no haya datos presentes en cache",
        () async {
      when(mockProductLocalDatasource.getProduct(any))
          .thenThrow(CacheException(message: "Error en cache"));

      final result = await repositoryImpl.getProduct(1);

      verifyZeroInteractions(mockProductRemoteDatasource);
      verify(mockProductLocalDatasource.getProduct(1));
      expect(result, Left(CacheFailure(message: "Error en cache")));
    });
  });

  group('Obtener producto individual', () {});

  group('Obtener todos los productos', () {
    List<ProductModel> listProductModelTest = [
      ProductModel(
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
      )
    ];

    List<ProductModel> listProductModel = listProductModelTest;

    test('Comprobar si se está verificando que el dispositivo está en línea',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repositoryImpl.getProducts();
      verify(mockNetworkInfo);
    });

    group('El dispositivo esta en línea', () {
      test(
          'Debe devolver datos remotos cuando la llamada a la fuente remota sea existosa',
          () async {
        when(mockProductRemoteDatasource.getProducts())
            .thenAnswer((realInvocation) async => listProductModelTest);

        final result = await repositoryImpl.getProducts();

        verify(mockProductRemoteDatasource.getProducts());
        expect(result, equals(Right(listProductModel)));
      });

      test(
          'Devolver el error de servidor cuando la llamada a la fuente remota no es exitosa',
          () async {
        when(mockProductRemoteDatasource.getProducts())
            .thenThrow(ServerException(message: "Error de servidor"));

        final result = await repositoryImpl.getProducts();
        verifyZeroInteractions(mockProductLocalDatasource);
        expect(result,
            equals(Left(ServerException(message: "Error de servidor"))));
      });
    });

    group('El dispositivo no esta en linea', () {});
  });
}
