class Prijava {
  String? id; // Dodato polje id
  final String teamName;
  final int numPlayers;
  final String emailUser;
  final String idKviza;
  final double kotizacija;

  Prijava({
    this.id,
    required this.teamName,
    required this.numPlayers,
    required this.emailUser,
    required this.idKviza,
    required this.kotizacija,
  });

  Map<String, dynamic> toJson() {
    return {
      'teamName': teamName,
      'numPlayers': numPlayers,
      'emailUser': emailUser,
      'idKviza': idKviza,
      'kotizacija': kotizacija,
    };
  }

  factory Prijava.fromJson(String id, Map<String, dynamic> json) {
    return Prijava(
      id: id,
      teamName: json['teamName'],
      numPlayers: json['numPlayers'],
      emailUser: json['emailUser'],
      idKviza: json['idKviza'],
      kotizacija: json['kotizacija'],
    );
  }
}
