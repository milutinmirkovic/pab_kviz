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


   Future<void> updateKviz(String? kvizId, int currentBrojSlobodnihIgraca, String? token) async {
    final url = Uri.parse('$baseUrl/$kvizId.json?=$token');
    final updatedBrojSlobodnihIgraca = currentBrojSlobodnihIgraca - 1;

    try {
      final response = await http.put(
        url,
        body: jsonEncode({'broj_slobodnih_mesta': updatedBrojSlobodnihIgraca}),
      );

      if (response.statusCode == 200) {
        print('Kviz updated successfully');
      } else {
        print('Failed to update kviz. Error: ${response.reasonPhrase}');
        // Handle error cases
      }
    } catch (e) {
      print('Exception occurred while updating kviz: $e');
      // Handle exceptions
    }
  }

}
