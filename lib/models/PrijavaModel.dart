import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/models/kviz.dart';

class Prijava {
  final String teamName;
  final int numPlayers;
  final Korisnik? user;
  final Kviz? kviz;

  Prijava({
    required this.teamName,
    required this.numPlayers,
    required this.user,
    required this.kviz
  });

  Map<String, dynamic> toJson() {
    return {
      'teamName': teamName,
      'numPlayers': numPlayers,
      'emailUser': user!.email,
      'idKviza': kviz!.id,
      'kotizacija': numPlayers*kviz!.cenaPoIgracu
    };
  }
}