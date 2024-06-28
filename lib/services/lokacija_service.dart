import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pab_kviz/models/lokacija.dart';

class LokacijaService {
  final String baseUrl = 'https://organizacija-pab-kvizova-default-rtdb.europe-west1.firebasedatabase.app/locations';

  // Method for adding a new Lokacija
  Future<void> addLokacija(Lokacija lokacija) async {
    final response = await http.post(
      Uri.parse('$baseUrl.json'),
      body: json.encode(lokacija.toMap()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add lokacija');
    }
  }

  // Method for updating an existing Lokacija
  Future<void> updateLokacija(Lokacija lokacija) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${lokacija.id}.json'),
      body: json.encode(lokacija.toMap()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update lokacija');
    }
  }

  // Method for fetching all Lokacije
  Future<List<Lokacija>> getLocations() async {
    final response = await http.get(Uri.parse('$baseUrl.json'));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print('Decoded data: $data');
      if (data != null && data.isNotEmpty) {
        return data
            .where((entry) => entry != null) // Filter out null entries
            .map((entry) {
          return Lokacija.fromMap(entry, "");
        }).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load locations');
    }
  }

  // Method for deleting an existing Lokacija
  Future<void> deleteLokacija(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id.json'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete lokacija');
    }
  }
}
