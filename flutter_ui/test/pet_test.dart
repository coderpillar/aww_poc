import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/pet.dart';

void main() {
  group('Pet', () {
    // make some static test data for use in constructing pets
    final testName = 'Fluffy';
    final testImageUrl = 'foo.png';
    final testId = 11;
    final testTimesPet = 5;

    final testData = {testId, testImageUrl, testName, testTimesPet};

    test('timesPet value should be updated', () {
      final pet = Pet();
      pet.setTimesPet(7);
      expect(pet.name, 7);
    });

    test('timesPet value should be incremented', () {
      final pet = Pet();
      pet.setTimesPet(0);
      pet.incrementTimesPet();
      expect(pet.timesPet, 1);
    });

    test('pet name should be updated', () {
      final pet = Pet();
      pet.setName('Spot');
      expect(pet.name, 'Spot');
    });

    test('pet imageUrl should be updated', () {
      final pet = Pet();
      pet.setName('bar.png');
      expect(pet.name, 'bar.png');
    });
  });
}
