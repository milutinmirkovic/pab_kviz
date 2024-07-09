import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pab_kviz/models/kategorija_kviza.dart';

class KategorijaKvizaService {
  final String baseUrl = 'https://organizacija-pab-kvizova-default-rtdb.europe-west1.firebasedatabase.app/kategorije_kviza';



  // GET kategorije
  Future<List<KategorijaKviza>> getKategorije(String token) async {
    final response = await http.get(Uri.parse('$baseUrl.json?auth=$token'));
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
      throw Exception('Kategorije nisu ucitane');
    }
  }

}
