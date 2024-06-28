import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pab_kviz/models/kategorija_kviza.dart';

class KategorijaKvizaService {
  final String baseUrl = 'https://organizacija-pab-kvizova-default-rtdb.europe-west1.firebasedatabase.app/kategorije_kviza';

  // Metoda za dodavanje nove kategorije kviza
  Future<void> addKategorija(KategorijaKviza kategorija) async {
    final response = await http.post(
      Uri.parse('$baseUrl.json'),
      body: json.encode(kategorija.toMap()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add kategorija kviza');
    }
  }

  // Metoda za ažuriranje postojeće kategorije kviza
  Future<void> updateKategorija(KategorijaKviza kategorija) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${kategorija.id}.json'),
      body: json.encode(kategorija.toMap()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update kategorija kviza');
    }
  }

  // Metoda za učitavanje svih kategorija kviza
  Future<List<KategorijaKviza>> getKategorije() async {
    final response = await http.get(Uri.parse('$baseUrl.json'));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print('Decoded data: $data');
      if (data != null && data.isNotEmpty) {
        return data
            .where((entry) => entry != null) // Filtrira null unose
            .map((entry) {
          return KategorijaKviza.fromMap(entry, ""); // Kreira instance KategorijaKviza
        }).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load kategorije kviza');
    }
  }

  // Metoda za brisanje postojeće kategorije kviza
  Future<void> deleteKategorija(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id.json'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete kategorija kviza');
    }
  }
}
