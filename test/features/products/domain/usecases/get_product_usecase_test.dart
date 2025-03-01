import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/entities/product_entity.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/entities/rating_entity.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/usecases/get_product_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clean_architecture/src/features/products/domain/repositories/product_repository.dart';

import 'get_product_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProductRepositoryInterface>()])
void main() {
  late GetProductUsecase usecase;
  late MockProductRepositoryInterface mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepositoryInterface();
    usecase = GetProductUsecase(repository: mockProductRepository);
  });

  const int testProductId = 1;
  final testProduct = ProductEntity(
    id: 1,
    title: 'Producto de prueba',
    price: 15.99,
    description: 'Descripcion',
    category: 'categoria',
    image: 'Image',
    rating: RatingEntity(count: 10, rate: 4.6),
  );

  test('Getting product', () async {
    when(mockProductRepository.getProduct(testProductId))
        .thenAnswer((realInvocation) async => Right(testProduct));

    final result = await usecase.call(Params(id: testProductId));

    expect(result, Right(testProduct));
    verify(mockProductRepository.getProduct(testProductId));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
