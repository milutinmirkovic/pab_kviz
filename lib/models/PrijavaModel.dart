class Prijava {
  final String teamName;
  final int numPlayers;
  final String emailUser;
  final String idKviza;
  final double kotizacija;

  Prijava({
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
}
