import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_ui/pet.dart';

// Create a MockClient using the Mock class provided by the Mockito package.
// Create new instances of this class in each test.
class MockClient extends Mock implements http.Client {}

main() {
  group('getPetsList', () {
    test('returns a list of Pets if the http call completes successfully',
        () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('http://localhost:5000/pets')))
          .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));

      expect(await getPetsList(client), isA<List<Pet>>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('http://localhost:5000/pets')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(getPetsList(client), throwsException);
    });
  });
}
