import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pab_kviz/models/PrijavaModel.dart';

class PrijavaService {
  final String baseUrl = 'https://organizacija-pab-kvizova-default-rtdb.europe-west1.firebasedatabase.app/prijave';

  // Metoda za ubacivanje nove prijave
  Future<void> createPrijava(Prijava prijava, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl.json?auth=$token'),
        body: jsonEncode(prijava.toJson()),
      );

      if (response.statusCode == 200) {
        print('Prijava created successfully');
      } else {
        print('Failed to create prijava. Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception occurred while creating prijava: $e');
    }
  }

  // Ostale metode (npr. za dohvatanje prijava, brisanje itd.)
}
