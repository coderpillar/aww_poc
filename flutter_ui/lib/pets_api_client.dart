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

  Future<Pet> getPet(http.Client client, int id) async {
    final response = await client
        .get(Uri.parse('https://10.0.2.2:5000/pets/${id.toString()}'));

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return petFromJson(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load pet');
    }
  }

  Future<Pet> postPet(http.Client client, int id, Pet pet) async {
    final response = await client.post(
        Uri.parse('https://10.0.2.2:5000/pets/${id.toString()}'),
        body: petToJson(pet));

    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON.
      return petFromJson(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to create pet');
    }
  }

  Future<Pet> putPet(http.Client client, int id, Pet pet) async {
    final response = await client.put(
        Uri.parse('https://10.0.2.2:5000/pets/${id.toString()}'),
        body: petToJson(pet));

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return petFromJson(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to update pet');
    }
  }

  Future deletePet(http.Client client, int id) async {
    final response = await client
        .put(Uri.parse('https://10.0.2.2:5000/pets/${id.toString()}'));

    if (response.statusCode == 204) {
      // If the call to the server was successful, parse the JSON.
      return;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to delete pet');
    }
  }
}
