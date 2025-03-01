import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  final List<dynamic> properties;

  Failures([this.properties = const <dynamic>[]]);

  @override
  List<Object?> get props => properties;
}

class ServerFailure extends Failures {
  final String message;

  ServerFailure({
    required this.message,
  });
}

class CacheFailure extends Failures {
  final String message;

  CacheFailure({
    required this.message,
  });
}
