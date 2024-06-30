import 'dart:convert';

class Lokacija {
  String? id;
  String adresa;
  String naziv;
  int kapacitet;
  String opis;
  String slika;

  Lokacija({
    this.id,
    required this.adresa,
    required this.naziv,
    required this.kapacitet,
    required this.opis,
    required this.slika
  });

  // Factory konstruktor za kreiranje instance Lokacija iz mape
  factory Lokacija.fromMap(Map<String, dynamic> data, String documentId) {
    return Lokacija(
      id: documentId.isEmpty ? null : documentId,
      adresa: data['adresa'],
      naziv: data['naziv'],
      kapacitet: data['kapacitet'],
      opis: data['opis'],
      slika: data['slika']
    );
  }

  // Metoda za konvertovanje instance Lokacija u mapu
  Map<String, dynamic> toMap() {
    return {
      'adresa': adresa,
      'naziv': naziv,
      'kapacitet': kapacitet,
      'opis':opis,
      'slika':slika
    };
  }

  // Metoda za konvertovanje instance Lokacija u JSON string
  String toJson() => json.encode(toMap());

  // Factory konstruktor za kreiranje instance Lokacija iz JSON stringa
  factory Lokacija.fromJson(String source) => Lokacija.fromMap(json.decode(source), "");
}
