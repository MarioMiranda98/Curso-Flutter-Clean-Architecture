import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/core/errors/failures.dart';
import 'package:flutter_clean_architecture/src/core/utils/input_converter.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/entities/product_entity.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/entities/rating_entity.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/usecases/get_all_products_usecase.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/usecases/get_product_usecase.dart';
import 'package:flutter_clean_architecture/src/features/products/presentation/providers/product_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_provider_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetAllProductsUsecase>(),
  MockSpec<GetProductUsecase>(),
  MockSpec<InputConverter>()
])
void main() {
  late ProductProvider provider;
  late MockGetAllProductsUsecase mockGetAllProductsUsecase;
  late MockGetProductUsecase mockGetProductUsecase;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetAllProductsUsecase = MockGetAllProductsUsecase();
    mockGetProductUsecase = MockGetProductUsecase();
    mockInputConverter = MockInputConverter();
    provider = ProductProvider(
      getProductUsecase: mockGetProductUsecase,
      getAllProductsUsecase: mockGetAllProductsUsecase,
      inputConverter: mockInputConverter,
    );
  });

  tearDown(() {
    provider.products.clear();
  });

  group(
    'Get product',
    () {
      //EL evento toma una cadena
      const testIdProduct = "9";
      //Salida exitosa del input converter
      final testIdInt = int.parse(testIdProduct);

      //Instancia de la entidad del producto
      final testProductEntity = ProductEntity(
        id: 9,
        title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ",
        price: 64.0,
        description:
            "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system",
        category: "electronics",
        image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg",
        rating: RatingEntity(
          rate: 3.3,
          count: 203,
        ),
      );

      test(
          'Debe llamar a InputConverter para validar y convertir la cadena a un entero',
          () async {
        when(mockInputConverter.stringToInt(any))
            .thenAnswer((_) => Right(testIdInt));

        when(mockGetProductUsecase(any))
            .thenAnswer((_) async => Right(testProductEntity));

        await provider.getProduct(testIdProduct);

        verify(mockInputConverter.stringToInt(testIdProduct));
      });

      test("Debe llamar un mensaje de error cuando no la entrada no es valida",
          () async {
        when(mockInputConverter.stringToInt(any)).thenReturn(Left(
            InvalidInputFailure(message: 'No se permiten números negativos')));

        final result = await provider.getProduct(testIdProduct);

        expect(result, const Left('No se permiten números negativos'));
      });

      test("Debe obtener datos del caso de uso", () async {
        when(mockInputConverter.stringToInt(any))
            .thenAnswer((_) => Right(testIdInt));

        //Configurar comportamiento a  la llamada al caso de uso para obtener un producto en especifico.
        when(mockGetProductUsecase(any))
            .thenAnswer((_) async => Right(testProductEntity));

        await provider.getProduct(testIdProduct);

        verify(mockGetProductUsecase((Params(id: testIdInt))));
      });

      test("Debería devolver un Right <ProductEntity>", () async {
        when(mockInputConverter.stringToInt(any))
            .thenAnswer((_) => Right(testIdInt));

        //Configurar comportamiento a  la llamada al caso de uso para obtener un producto en especifico.
        when(mockGetProductUsecase(any))
            .thenAnswer((_) async => Right(testProductEntity));

        final result = await provider.getProduct(testIdProduct);

        expect(result, Right(testProductEntity));
      });

      test(
          'Debería devolver un mensaje de error cuando falla la obtención de datos',
          () async {
        when(mockInputConverter.stringToInt(any))
            .thenAnswer((_) => Right(testIdInt));

        when(mockGetProductUsecase(any)).thenAnswer(
            (_) async => Left(ServerFailure(message: 'Server Failure')));

        final result = await provider.getProduct(testIdProduct);

        expect(result, const Left('Server Failure'));
        verify(mockGetProductUsecase(Params(id: testIdInt)));
      });

      test(
          'Debería devolver un mensaje de error cuando falla la obtención de datos desde el cache',
          () async {
        when(mockInputConverter.stringToInt(any))
            .thenAnswer((_) => Right(testIdInt));

        when(mockGetProductUsecase(any)).thenAnswer(
            (_) async => Left(CacheFailure(message: 'Cache Failure')));

        final result = await provider.getProduct(testIdProduct);

        expect(result, const Left('Cache Failure'));
        verify(mockGetProductUsecase(Params(id: testIdInt)));
      });
    },
  );

  group('Get all Products', () {
    final testProductEntity = ProductEntity(
      id: 9,
      title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ",
      price: 64.0,
      description:
          "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system",
      category: "electronics",
      image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg",
      rating: RatingEntity(
        rate: 3.3,
        count: 203,
      ),
    );

    final listTestProductEntity = [testProductEntity];

    test(
        "Debería devolver los productos guardados cuando los hay sin tener interacción con el caso de grupo",
        () async {
      //Añadimos los productos esperados a la lista de productos del provider
      provider.products = List.from(listTestProductEntity);

      //Llamamos a la función para obtener todos los productos
      final result = await provider.getProducts();

      //Esperar que la lista de productos este vacia
      expect(provider.products, isNotNull);

      expect(result, Right(provider.products));

      verifyZeroInteractions(mockGetAllProductsUsecase);
    });

    test("Debería llamar al caso de uso correctamente", () async {
      when(mockGetAllProductsUsecase(NoParams()))
          .thenAnswer((realInvocation) async => Right(listTestProductEntity));

      await provider.getProducts();

      verify(mockGetAllProductsUsecase(NoParams()));
    });

    test("Debería devolver un Right y los productos correctamente", () async {
      //Configurar comportamiento a  la llamada al caso de uso para obtener un producto en especifico.
      when(mockGetAllProductsUsecase(NoParams()))
          .thenAnswer((_) async => Right(listTestProductEntity));

      final result = await provider.getProducts();

      expect(provider.products, equals(listTestProductEntity));
      expect(result, Right(listTestProductEntity));
      verify(mockGetAllProductsUsecase(NoParams()));
    });

    test(
        "Debería devolver un mensaje de error cuando falla la obtención de datos del cache",
        () async {
      when(mockGetAllProductsUsecase(NoParams())).thenAnswer(
          (_) async => Left(CacheFailure(message: "Error en cache")));

      final result = await provider.getProducts();

      expect(result, const Left("Error en cache"));
      verify(mockGetAllProductsUsecase(NoParams()));
    });

    test(
        "Debería devolver un mensaje de error cuando falla la obtención de datos del remote",
        () async {
      when(mockGetAllProductsUsecase(NoParams())).thenAnswer(
          (_) async => Left(ServerFailure(message: "Error en servidor")));

      final result = await provider.getProducts();

      expect(result, const Left("Error en servidor"));
      verify(mockGetAllProductsUsecase(NoParams()));
    });
  });
}
