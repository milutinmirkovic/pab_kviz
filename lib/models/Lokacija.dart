import 'dart:convert';

class Lokacija {
  String? id;
  String adresa;
  String naziv;
  int kapacitet;

  Lokacija({
    this.id,
    required this.adresa,
    required this.naziv,
    required this.kapacitet,
  });

  // Factory constructor for creating a new Lokacija instance from a map
  factory Lokacija.fromMap(Map<String, dynamic> data, String documentId) {
    return Lokacija(
      id: documentId.isEmpty ? null : documentId,
      adresa: data['adresa'],
      naziv: data['naziv'],
      kapacitet: data['kapacitet'],
    );
  }

  // Method for converting a Lokacija instance to a map
  Map<String, dynamic> toMap() {
    return {
      'adresa': adresa,
      'naziv': naziv,
      'kapacitet': kapacitet,
    };
  }

  // Method for converting a Lokacija instance to a JSON string
  String toJson() => json.encode(toMap());

  // Factory constructor for creating a new Lokacija instance from a JSON string
  factory Lokacija.fromJson(String source) => Lokacija.fromMap(json.decode(source), "");
}
