import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/pet.dart';
import 'package:pet_finder.dart';

void main() {
  group('PetFinder', () {
    test('findName method should return non-zero lenght string', () {
      final finder = PetFinder();
      var name = finder.findName();
      expect(name, hasLength);
    });

    test('findImage method should return non-zero lenght string', () {
      final finder = PetFinder();
      var image = finder.findImage();
      expect(image, hasLength);
    });
  });
}
