class Prijava {
  String? id;
  final String teamName;
  final double numPlayers; 
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

  factory Prijava.fromMap(String id, Map<String, dynamic> map) {
    return Prijava(
      id: id,
      teamName: map['teamName'],
      numPlayers: map['numPlayers'] is double
          ? map['numPlayers']
          : double.tryParse(map['numPlayers'].toString()) ?? 0.0,
      emailUser: map['emailUser'],
      idKviza: map['idKviza'],
      kotizacija: map['kotizacija'] is double
          ? map['kotizacija']
          : double.tryParse(map['kotizacija'].toString()) ?? 0.0,
    );
  }
}
