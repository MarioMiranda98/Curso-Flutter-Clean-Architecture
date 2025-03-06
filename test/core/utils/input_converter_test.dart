import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/core/utils/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('String to Int', () {
    const String str = '9';
    test(
        'Debería devolver un número entero cuando la cadena representa un número entero válido',
        () async {
      final result = inputConverter.stringToInt(str);

      expect(result, const Right(9));
    });

    test('Debería devolver un error cuando la cadena no es un número entero',
        () async {
      final result = inputConverter.stringToInt('abc');

      expect(result, Left(InvalidInputFailure(message: '')));
    });

    test('Debería devolver un error cuando la cadena es un entero negativo',
        () async {
      const String negativeStr = '-9';
      final result = inputConverter.stringToInt(negativeStr);

      expect(result, Left(InvalidInputFailure(message: '')));
    });
  });
}
