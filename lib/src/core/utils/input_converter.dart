import 'package:dartz/dartz.dart';

import 'package:flutter_clean_architecture/src/core/errors/failures.dart';

class InputConverter {
  Either<Failures, int> stringToInt(String str) {
    try {
      final integer = int.parse(str);

      return integer >= 0
          ? Right(integer)
          : Left(
              InvalidInputFailure(message: 'No se permiten números negativos'));
    } on FormatException catch (error) {
      return Left(InvalidInputFailure(message: error.message));
    }
  }
}

class InvalidInputFailure extends Failures {
  final String message;

  InvalidInputFailure({required this.message});
}
