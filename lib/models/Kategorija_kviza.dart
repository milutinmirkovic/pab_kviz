import 'dart:convert';

class KategorijaKviza {
  String? id;
  String naziv;
  bool humanitarni;

  KategorijaKviza({
    this.id,
    required this.naziv,
    required this.humanitarni,
  });

  // Factory konstruktor za kreiranje instance KategorijaKviza iz mape
  factory KategorijaKviza.fromMap(Map<String, dynamic> data, String documentId) {
    return KategorijaKviza(
      id: documentId.isEmpty ? null : documentId,
      naziv: data['naziv'],
      humanitarni: data['humanitarni'],
    );
  }

  // Metoda za konvertovanje instance KategorijaKviza u mapu
  Map<String, dynamic> toMap() {
    return {
      'naziv': naziv,
      'humanitarni': humanitarni,
    };
  }

  // Metoda za konvertovanje instance KategorijaKviza u JSON string
  String toJson() => json.encode(toMap());

  // Factory konstruktor za kreiranje instance KategorijaKviza iz JSON stringa
  factory KategorijaKviza.fromJson(String source) => KategorijaKviza.fromMap(json.decode(source), "");
}
