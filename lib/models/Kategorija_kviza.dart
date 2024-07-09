import 'dart:convert';

class KategorijaKviza {
  String? id;
  String naziv;
  bool humanitarni;
  String opis;
  String slika;


  KategorijaKviza({
    this.id,
    required this.naziv,
    required this.humanitarni,
    required this.opis,
    required this.slika
  });


  factory KategorijaKviza.fromMap(Map<String, dynamic> data, String documentId) {
    return KategorijaKviza(
      id: documentId.isEmpty ? null : documentId,
      naziv: data['naziv'],
      humanitarni: data['humanitarni'],
      opis: data['opis'],
      slika: data['slika'],
    );
  }

 
  Map<String, dynamic> toMap() {
    return {
      'naziv': naziv,
      'humanitarni': humanitarni,
      'opis': opis,
      'slika': slika,
    };
  }

  
  String toJson() => json.encode(toMap());

  
  factory KategorijaKviza.fromJson(String source) => KategorijaKviza.fromMap(json.decode(source), "");
}
