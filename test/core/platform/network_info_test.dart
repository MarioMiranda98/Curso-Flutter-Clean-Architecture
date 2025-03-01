import 'package:flutter_clean_architecture/src/core/platform/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateNiceMocks([MockSpec<InternetConnectionChecker>()])
void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl =
        NetworkInfoImpl(connectionChecker: mockInternetConnectionChecker);
  });

  test(
      "Debería llamar correctamente al método InternetConecctionChecker().hasConnection",
      () async {
    final hasConnection = Future.value(true);

    when(mockInternetConnectionChecker.hasConnection)
        .thenAnswer((_) async => hasConnection);

    final result = networkInfoImpl.isConnected;
    verify(mockInternetConnectionChecker.hasConnection);
    expect(result, hasConnection);
  });
}
