import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/models/kviz.dart';

class KvizService {
  final String baseUrl = 'https://organizacija-pab-kvizova-default-rtdb.europe-west1.firebasedatabase.app/kvizovi';
  final Korisnik user;
  KvizService({required this.user});

  // Metoda za učitavanje svih kvizova
  Future<List<Kviz>> getKvizovi() async {
    final response = await http.get(Uri.parse('$baseUrl.json'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      if (data != null && data.isNotEmpty) {
        return data.entries.map((entry) {
          return Kviz.fromMap(entry.value, entry.key);
        }).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load kvizovi');
    }
  }
}
