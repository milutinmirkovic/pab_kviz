import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/models/kviz.dart';

class KvizService {
  final String baseUrl = 'https://organizacija-pab-kvizova-default-rtdb.europe-west1.firebasedatabase.app/kvizovi';


  // Metoda za učitavanje svih kvizova
  Future<List<Kviz>> getKvizovi( String token) async {
    final response = await http.get(Uri.parse('$baseUrl.json?auth=$token'));
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

 Future<void> addKviz(Kviz kviz, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl.json?auth=$token'),
      body: kviz.toJson(),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add kviz');
    }
  }



}
