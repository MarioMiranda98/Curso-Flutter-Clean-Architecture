// Mocks generated by Mockito 5.4.4 from annotations
// in flutter_clean_architecture/test/features/products/presentation/providers/product_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:flutter_clean_architecture/src/core/errors/failures.dart'
    as _i6;
import 'package:flutter_clean_architecture/src/core/utils/input_converter.dart'
    as _i9;
import 'package:flutter_clean_architecture/src/features/products/domain/entities/product_entity.dart'
    as _i7;
import 'package:flutter_clean_architecture/src/features/products/domain/repositories/product_repository.dart'
    as _i2;
import 'package:flutter_clean_architecture/src/features/products/domain/usecases/get_all_products_usecase.dart'
    as _i4;
import 'package:flutter_clean_architecture/src/features/products/domain/usecases/get_product_usecase.dart'
    as _i8;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeProductRepositoryInterface_0 extends _i1.SmartFake
    implements _i2.ProductRepositoryInterface {
  _FakeProductRepositoryInterface_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetAllProductsUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetAllProductsUsecase extends _i1.Mock
    implements _i4.GetAllProductsUsecase {
  @override
  _i2.ProductRepositoryInterface get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeProductRepositoryInterface_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeProductRepositoryInterface_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.ProductRepositoryInterface);

  @override
  _i5.Future<_i3.Either<_i6.Failures, List<_i7.ProductEntity>>> call(
          _i4.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failures, List<_i7.ProductEntity>>>.value(
                _FakeEither_1<_i6.Failures, List<_i7.ProductEntity>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failures, List<_i7.ProductEntity>>>.value(
                _FakeEither_1<_i6.Failures, List<_i7.ProductEntity>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failures, List<_i7.ProductEntity>>>);
}

/// A class which mocks [GetProductUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetProductUsecase extends _i1.Mock implements _i8.GetProductUsecase {
  @override
  _i2.ProductRepositoryInterface get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeProductRepositoryInterface_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeProductRepositoryInterface_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.ProductRepositoryInterface);

  @override
  _i5.Future<_i3.Either<_i6.Failures, _i7.ProductEntity>> call(
          _i8.Params? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failures, _i7.ProductEntity>>.value(
                _FakeEither_1<_i6.Failures, _i7.ProductEntity>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failures, _i7.ProductEntity>>.value(
                _FakeEither_1<_i6.Failures, _i7.ProductEntity>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failures, _i7.ProductEntity>>);
}

/// A class which mocks [InputConverter].
///
/// See the documentation for Mockito's code generation for more information.
class MockInputConverter extends _i1.Mock implements _i9.InputConverter {
  @override
  _i3.Either<_i6.Failures, int> stringToInt(String? str) => (super.noSuchMethod(
        Invocation.method(
          #stringToInt,
          [str],
        ),
        returnValue: _FakeEither_1<_i6.Failures, int>(
          this,
          Invocation.method(
            #stringToInt,
            [str],
          ),
        ),
        returnValueForMissingStub: _FakeEither_1<_i6.Failures, int>(
          this,
          Invocation.method(
            #stringToInt,
            [str],
          ),
        ),
      ) as _i3.Either<_i6.Failures, int>);
}
