class Tournament {
  final String key;
  String name;
  String country;
  String place;
  Tournament({this.key, this.name, this.country, this.place});
  Tournament clone({name, country, place}) {
    return Tournament(
        key: this.key ?? this.key,
        name: name ?? this.name,
        country: country ?? this.country,
        place: place ?? this.place);
  }

  @override
  String toString() {
    return "Tournament($name, $country, $place)";
  }
}
