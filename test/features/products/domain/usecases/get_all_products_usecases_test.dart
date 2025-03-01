import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/entities/product_entity.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/entities/rating_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clean_architecture/src/features/products/domain/usecases/get_all_products_usecase.dart';
import 'get_product_usecase_test.mocks.dart';
import 'package:mockito/mockito.dart';

void main() {
  late GetAllProductsUsecase usecase;
  late MockProductRepositoryInterface mockProductRepositoryInterface;

  setUp(() {
    mockProductRepositoryInterface = MockProductRepositoryInterface();
    usecase = GetAllProductsUsecase(repository: mockProductRepositoryInterface);
  });

  final testProduct = ProductEntity(
    id: 1,
    title: 'Producto de prueba',
    price: 15.99,
    description: 'Descripcion',
    category: 'categoria',
    image: 'Image',
    rating: RatingEntity(count: 10, rate: 4.6),
  );

  test('Getting all products', () async {
    when(mockProductRepositoryInterface.getProducts())
        .thenAnswer((realInvocation) async => Right([testProduct]));

    final result = await usecase(NoParams());
    expect(result, Right([testProduct]));
    verify(mockProductRepositoryInterface.getProducts());
    verifyNoMoreInteractions(mockProductRepositoryInterface);
  });
}
