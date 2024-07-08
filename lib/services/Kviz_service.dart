import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/models/Lokacija.dart';
import 'package:pab_kviz/models/kviz.dart';

class KvizService {
  
  final String baseUrl = 'https://organizacija-pab-kvizova-default-rtdb.europe-west1.firebasedatabase.app/kvizovi';
final String lokacijeURL = 'https://organizacija-pab-kvizova-default-rtdb.europe-west1.firebasedatabase.app/lokacije';
final String prijaveUrl = 'https://organizacija-pab-kvizova-default-rtdb.europe-west1.firebasedatabase.app/prijave';
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





   Future<void> updateMesta(String? kvizId, int currentBrojSlobodnihIgraca, String? token) async {
    final url = Uri.parse('$baseUrl/$kvizId.json?auth=$token');
    final updatedBrojSlobodnihIgraca = currentBrojSlobodnihIgraca - 1;

    try {
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json'},
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
  Future<Lokacija> getLokacija(String lokacijaId, String token) async {
  final response = await http.get(Uri.parse('$lokacijeURL/$lokacijaId.json?auth=$token'));
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    return Lokacija.fromMap(data, lokacijaId);
  } else {
    throw Exception('Failed to load lokacija');
  }
}


Future<void> deleteKviz(String kvizId, String token) async {
    final url = Uri.parse('$baseUrl/$kvizId.json?auth=$token');
    try {
       await deletePrijaveForKviz(kvizId, token);
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        print('Kviz deleted successfully');
      } else {
        print('Failed to delete kviz. Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception occurred while deleting kviz: $e');
    }
  }


Future<void> updateKviz(Kviz kviz, String token) async {
    final url = Uri.parse('$baseUrl/${kviz.id}.json?auth=$token');
    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: kviz.toJson(),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update kviz');
    }
  }


Future<void> deletePrijaveForKviz(String kvizId, String token) async {
    final response = await http.get(Uri.parse('$prijaveUrl.json?auth=$token'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      data.forEach((key, value) async {
        if (value['kvizId'] == kvizId) {
          final deleteUrl = Uri.parse('$prijaveUrl/$key.json?auth=$token');
          await http.delete(deleteUrl);
        }
      });
    } else {
      throw Exception('Failed to load prijave');
    }
}

}
