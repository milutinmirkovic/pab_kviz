import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pab_kviz/models/lokacija.dart';

class LokacijaService {
  final String baseUrl = 'https://organizacija-pab-kvizova-default-rtdb.europe-west1.firebasedatabase.app/lokacije';

  



  // Metod za učitavanje svih Lokacija
  Future<List<Lokacija>> getLocations(String token) async {
    final response = await http.get(Uri.parse('$baseUrl.json?auth=$token'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<Lokacija> lokacije = [];
      data.forEach((key, value) {
        Lokacija lokacija = Lokacija.fromMap(value, key);
        lokacije.add(lokacija);
      });
      print('Loaded locations: $lokacije'); // Dodato za ispisivanje lokacija
      return lokacije;
    } else {
      print('Failed to load locations: ${response.reasonPhrase}');
      throw Exception('Failed to load locations');
    }
  }



  Future<void> createLokacija(Lokacija lokacija, String authToken) async {
    final url = Uri.parse('$baseUrl.json?auth=$authToken');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(lokacija.toJson()),
      );

      if (response.statusCode == 200) {
        print('Lokacija created successfully');
      } else {
        print('Failed to create lokacija. Error: ${response.reasonPhrase}');
        // Handle error cases
      }
    } catch (e) {
      print('Exception occurred while creating lokacija: $e');
      // Handle exceptions
    }
  }
}
