class Cat {
  String? breed;
  String? contry;
  String? origin;
  String? coat;
  String? pattern;

  Cat({this.breed, this.coat, this.contry, this.origin, this.pattern});

  Cat.fromapi(Map<String, dynamic> JsonData) {
    breed = JsonData['breed'];
    contry = JsonData['contry'];
    origin = JsonData['origin'];
    coat = JsonData['coat'];
    pattern = JsonData['pattern'];
  }
}
