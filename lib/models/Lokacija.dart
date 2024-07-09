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

  
  Map<String, dynamic> toMap() {
    return {
      'adresa': adresa,
      'naziv': naziv,
      'kapacitet': kapacitet,
      'opis':opis,
      'slika':slika
    };
  }


  Map<String, dynamic> toJson() {
    return {
      'adresa': adresa,
      'naziv': naziv,
      'kapacitet': kapacitet,
      'opis':opis,
      'slika':slika
    };
  }

 
  factory Lokacija.fromJson(String source) => Lokacija.fromMap(json.decode(source), "");
  
}
