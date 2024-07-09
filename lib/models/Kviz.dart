class Kviz {
  final String? id;
  final String naziv;
  final String tip;
  final String vreme;
  final String datum;
  final double cenaPoIgracu;
  final String lokacijaId;
  final int brojSlobodnihMesta;
  final List<String> ucesca;

  Kviz({
    this.id,
    required this.naziv,
    required this.tip,
    required this.vreme,
    required this.datum,
    required this.cenaPoIgracu,
    required this.lokacijaId,
    required this.brojSlobodnihMesta,
    required this.ucesca,
  });

  Map<String, dynamic> toJson() {
    return {
      'naziv': naziv,
      'tip': tip,
      'vreme': vreme,
      'datum': datum,
      'cena_po_igracu': cenaPoIgracu,
      'lokacija_id': lokacijaId,
      'broj_slobodnih_mesta': brojSlobodnihMesta,
      'ucesca': ucesca,
    };
  }

  factory Kviz.fromMap(Map<String, dynamic> data, String documentId) {
    return Kviz(
      id: documentId,
      naziv: data['naziv'],
      tip: data['tip'],
      vreme: data['vreme'],
      datum: data['datum'],
      cenaPoIgracu: data['cena_po_igracu'],
      lokacijaId: data['lokacija_id'],
      brojSlobodnihMesta: data['broj_slobodnih_mesta'],
      ucesca: List<String>.from(data['ucesca'] ?? []),
    );
  }
}
