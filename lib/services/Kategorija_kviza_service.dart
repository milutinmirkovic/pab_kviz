import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pab_kviz/models/kategorija_kviza.dart';

class KategorijaKvizaService {
  final String baseUrl = 'https://organizacija-pab-kvizova-default-rtdb.europe-west1.firebasedatabase.app/kategorije_kviza';

  // Metod za dodavanje nove kategorije kviza
  Future<void> addKategorija(KategorijaKviza kategorija) async {
    final response = await http.post(
      Uri.parse('$baseUrl.json'),
      body: json.encode(kategorija.toMap()),
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      kategorija.id = responseData['name']; // Čuvanje ID-a nove kategorije
    } else {
      throw Exception('Failed to add kategorija kviza');
    }
  }

  // Metod za ažuriranje postojeće kategorije kviza
  Future<void> updateKategorija(KategorijaKviza kategorija) async {
    if (kategorija.id == null) throw ArgumentError('Kategorija must have an id to be updated.');
    final response = await http.put(
      Uri.parse('$baseUrl/${kategorija.id}.json'),
      body: json.encode(kategorija.toMap()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update kategorija kviza');
    }
  }

  // Metod za učitavanje svih kategorija kviza
  Future<List<KategorijaKviza>> getKategorije() async {
    final response = await http.get(Uri.parse('$baseUrl.json'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return data.entries.map((entry) {
          return KategorijaKviza.fromMap(entry.value, entry.key);
        }).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load kategorije kviza');
    }
  }

  // Metod za brisanje postojeće kategorije kviza
  Future<void> deleteKategorija(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id.json'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete kategorija kviza');
    }
  }
}
