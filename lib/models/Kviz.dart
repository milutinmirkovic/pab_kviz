import 'dart:convert';

class Kviz {
  String? id;
  String naziv;
  String tip;
  String vreme;
  double cenaPoIgracu;
  String lokacijaId;
  int brojSlobodnihMesta;
  List<String> ucesca;

  Kviz({
    this.id,
    required this.naziv,
    required this.tip,
    required this.vreme,
    required this.cenaPoIgracu,
    required this.lokacijaId,
    required this.brojSlobodnihMesta,
    required this.ucesca,
  });

  // Factory konstruktor za kreiranje instance Kviz iz mape
  factory Kviz.fromMap(Map<String, dynamic> data, String documentId) {
    return Kviz(
      id: documentId.isEmpty ? null : documentId,
      naziv: data['naziv'],
      tip: data['tip'],
      vreme: data['vreme'],
      cenaPoIgracu: data['cena_po_igracu'],
      lokacijaId: data['lokacija_id'],
      brojSlobodnihMesta: data['broj_slobodnih_mesta'],
      ucesca: List<String>.from(data['ucesca'] ?? []),
    );
  }

  // Metoda za konvertovanje instance Kviz u mapu
  Map<String, dynamic> toMap() {
    return {
      'naziv': naziv,
      'tip': tip,
      'vreme': vreme,
      'cena_po_igracu': cenaPoIgracu,
      'lokacija_id': lokacijaId,
      'broj_slobodnih_mesta': brojSlobodnihMesta,
      'ucesca': ucesca,
    };
  }

  // Metoda za konvertovanje instance Kviz u JSON string
  String toJson() => json.encode(toMap());

  // Factory konstruktor za kreiranje instance Kviz iz JSON stringa
  factory Kviz.fromJson(String source) => Kviz.fromMap(json.decode(source), "");
}
