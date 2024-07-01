import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pab_kviz/models/Korisnik.dart';

import 'package:pab_kviz/models/PrijavaModel.dart';

class PrijavaService{
  final String baseUrl = 'https://organizacija-pab-kvizova-default-rtdb.europe-west1.firebasedatabase.app/prijave';


  //metoda za ubacivanje nove prijave


  Future<void> createPrijava(Prijava prijava) async {
    //final url = Uri.parse('$baseUrl/prijave.json');
    final Korisnik? user = prijava.user;
    final String? token = user!.token;

    try {
      final response = await http.post(
        Uri.parse('$baseUrl.json?auth=$token'),
        body: jsonEncode(prijava.toJson()),
      );

      if (response.statusCode == 200) {
        print('Prijava created successfully');
      } else {
        print('Failed to create prijava. Error: ${response.reasonPhrase}');
        // Handle error cases
      }
    } catch (e) {
      print('Exception occurred while creating prijava: $e');
      // Handle exceptions
    }
  }

  //metoda za update kviz - smanjenje broja slobodnih mesta

  


}