// To parse this JSON data, do
//
//     final petsList = petsListFromJson(jsonString);

//  This class was generated with https://app.quicktype.io/

import 'dart:convert';

List<Pet> petsListFromJson(String str) =>
    List<Pet>.from(json.decode(str).map((x) => Pet.fromJson(x)));

String petsListToJson(List<Pet> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pet {
  Pet({
    this.id,
    this.imageUrl,
    this.name,
    this.timesPet,
  });

  int id;
  String imageUrl;
  String name;
  int timesPet;

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        id: json["id"],
        imageUrl: json["image_url"],
        name: json["name"],
        timesPet: json["times_pet"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "name": name,
        "times_pet": timesPet,
      };

  void setName(String name) => this.name = name;

  void setImageUrl(String url) => this.imageUrl = url;

  void setId(int id) => this.id = id;

  void setTimesPet(int timesPet) => this.timesPet = timesPet;

  void incrementTimesPet() => this.timesPet++;
}
