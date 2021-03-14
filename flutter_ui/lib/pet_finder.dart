import 'package:random_names/random_names.dart';
import 'package:lorem_cutesum/lorem_cutesum.dart';

class PetFinder {
  PetFinder();

  //generate list of random names and return the first (only) element
  String findName() {
    return generateRandomNames(1)[0];
  }

  String findImageUrl() {
    return Cutesum.randomImageUrl();
  }
}
