import 'package:dartz/dartz.dart';

import 'package:flutter_clean_architecture/src/core/errors/failures.dart';

abstract class Usecases<T, P> {
  Future<Either<Failures, T>> call(P params);
}
