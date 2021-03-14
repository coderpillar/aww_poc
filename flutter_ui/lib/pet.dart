class Pet {
  int id;
  String name;
  String imageUrl;
  int timesPet;

  //Constructor with id and timesPet (default value of 0) as optional parameters
  Pet(this.name, this.imageUrl, [this.timesPet = 0, this.id = -1]);

  void setName(String name) => this.name = name;

  void setImageUrl(String url) => this.imageUrl = url;

  void setId(int id) => this.id;

  void incrementTimesPet() => this.timesPet++;
}
