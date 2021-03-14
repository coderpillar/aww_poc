import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/pet_finder.dart';

void main() {
  group('PetFinder', () {
    test('findName method should return non-zero lenght string', () {
      final finder = PetFinder();
      var name = finder.findName();
      expect(name.length, isNot(equals(0)));
    });

    test('findImage method should return non-zero lenght string', () {
      final finder = PetFinder();
      var image = finder.findImageUrl();
      expect(image.length, isNot(equals(0)));
    });
  });
}
