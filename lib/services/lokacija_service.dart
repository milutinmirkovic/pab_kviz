import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pab_kviz/models/lokacija.dart';

class LokacijaService {
  final String baseUrl = 'https://organizacija-pab-kvizova-default-rtdb.europe-west1.firebasedatabase.app/lokacije';

  // Metod za dodavanje nove Lokacije
  Future<void> addLokacija(Lokacija lokacija, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl.json?auth=$token'),
      body: json.encode(lokacija.toMap()),
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      lokacija.id = responseData['name']; // Čuvanje ID-a nove lokacije
    } else {
      throw Exception('Failed to add lokacija');
    }
  }

  // Metod za ažuriranje postojeće Lokacije
  Future<void> updateLokacija(Lokacija lokacija, String token) async {
    if (lokacija.id == null) throw ArgumentError('Lokacija must have an id to be updated.');
    final response = await http.put(
      Uri.parse('$baseUrl/${lokacija.id}.json?auth=$token'),
      body: json.encode(lokacija.toMap()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update lokacija');
    }
  }

  // Metod za učitavanje svih Lokacija
  Future<List<Lokacija>> getLocations(String token) async {
    final response = await http.get(Uri.parse('$baseUrl.json?auth=$token'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return data.entries.map((entry) {
          return Lokacija.fromMap(entry.value, entry.key);
        }).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load locations');
    }
  }

  // Metod za brisanje postojeće Lokacije
  Future<void> deleteLokacija(String id, String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id.json?auth=$token'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete lokacija');
    }
  }
}
