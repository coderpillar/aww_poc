import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/pet.dart';

void main() {
  group('Pet', () {
    // make some static test data for use in constructing pets
    final testName = 'Fluffy';
    final testImageUrl = 'foo.png';
    final testTimesPet = 4;
    final testId = 99;

    test('timesPet should start at 0 if not initialized', () {
      final pet = Pet(testName, testImageUrl);
      expect(pet.timesPet, 0);
    });

    test('timesPet value should be incremented', () {
      final pet = Pet(testName, testImageUrl);
      pet.incrementTimesPet();
      expect(pet.timesPet, 1);
    });

    test('pet name should be updated', () {
      final pet = Pet(testName, testImageUrl);
      pet.setName('Spot');
      expect(pet.name, 'Spot');
    });

    test('pet imageUrl should be updated', () {
      final pet = Pet(testName, testImageUrl);
      pet.setName('bar.png');
      expect(pet.name, 'bar.png');
    });
  });
}
