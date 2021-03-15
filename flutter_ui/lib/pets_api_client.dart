import 'package:flutter_ui/pet.dart';
import 'package:http/http.dart' as http;

class PetsApiClient {
  Future<List<Pet>> getPetsList(http.Client client) async {
    final response = await client.get(Uri.parse('https://10.0.2.2:5000/pets'));

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return petsListFromJson(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load pets list');
    }
  }
}
