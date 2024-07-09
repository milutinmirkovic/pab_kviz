import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pab_kviz/models/Lokacija.dart';
import 'package:pab_kviz/models/kviz.dart';
import 'package:pab_kviz/models/PrijavaModel.dart';

class KvizService {

  
  final String baseUrl = 'https://organizacija-pab-kvizova-default-rtdb.europe-west1.firebasedatabase.app/kvizovi';
  final String prijaveUrl = 'https://organizacija-pab-kvizova-default-rtdb.europe-west1.firebasedatabase.app/prijave';
  final String lokacijeUrl = 'https://organizacija-pab-kvizova-default-rtdb.europe-west1.firebasedatabase.app/lokacije';





// Dodavanje kviza
  Future<void> insertKviz(Kviz kviz, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl.json?auth=$token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(kviz.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Neuspešno dodavanje kviza');
    }
  }

  // Ažuriranje kviza
  Future<void> updateKviz(Kviz kviz, String token) async {
    final url = Uri.parse('$baseUrl/${kviz.id}.json?auth=$token');
    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(kviz.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Neuspešno ažuriranje kviza');
    }
  }

  // Dobijanje svih kvizova
  Future<List<Kviz>> getKvizovi(String token) async {
    final response = await http.get(Uri.parse('$baseUrl.json?auth=$token'));
    if (response.statusCode == 200) {
      Map<String, dynamic>? data = json.decode(response.body);
      if (data == null) {
        return [];
      }
      List<Kviz> kvizovi = [];
      data.forEach((key, value) {
        Kviz kviz = Kviz.fromMap(value, key);
        kvizovi.add(kviz);
      });
      return kvizovi;
    } else {
      throw Exception('Neuspešno učitavanje kvizova');
    }
  }







  // Ažuriranje broja slobodnih mesta
  Future<void> updateMesta(String kvizId, int currentBrojSlobodnihIgraca, String token) async {
    final url = Uri.parse('$baseUrl/$kvizId.json?auth=$token');
    final updatedBrojSlobodnihIgraca = currentBrojSlobodnihIgraca - 1;

    try {
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'broj_slobodnih_mesta': updatedBrojSlobodnihIgraca}),
      );

      if (response.statusCode != 200) {
        throw Exception('Neuspešno ažuriranje kviza');
      }
    } catch (e) {
      throw Exception('Greška prilikom ažuriranja kviza: $e');
    }
  }

  // Dobijanje prijava za kviz
  Future<List<Prijava>> getPrijaveZaKviz(String kvizId, String token) async {
  try {
    final response = await http.get(Uri.parse('$prijaveUrl.json?auth=$token'));
    if (response.statusCode == 200) {
      Map<String, dynamic>? data = json.decode(response.body);
      if (data == null) {
        return [];
      }
      List<Prijava> prijave = [];
      data.forEach((key, value) {
        if (value['idKviza'] == kvizId) {
          Prijava prijava = Prijava.fromMap(key, value);
          prijave.add(prijava);
        }
      });
      return prijave;
    } else {
      throw Exception('Neuspešno učitavanje prijava: ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    print('Greška prilikom učitavanja prijava: $e');
    throw Exception('Greška prilikom učitavanja prijava: $e');
  }
}

  // Brisanje prijave
  Future<bool> deletePrijava(String prijavaId, String token) async {
    final url = Uri.parse('$prijaveUrl/$prijavaId.json?auth=$token');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // Brisanje kviza
  Future<void> deleteKviz(String kvizId, String token) async {
    final url = Uri.parse('$baseUrl/$kvizId.json?auth=$token');
    try {
      await deletePrijaveZaKviz(kvizId, token);
      final response = await http.delete(url);
      if (response.statusCode != 200) {
        throw Exception('Neuspešno brisanje kviza');
      }
    } catch (e) {
      throw Exception('Greška prilikom brisanja kviza: $e');
    }
  }

  // Brisanje prijava za kviz
  Future<void> deletePrijaveZaKviz(String kvizId, String token) async {
    final response = await http.get(Uri.parse('$prijaveUrl.json?auth=$token'));
    if (response.statusCode == 200) {
      Map<String, dynamic>? data = json.decode(response.body);
      if (data != null) {
        data.forEach((key, value) async {
          if (value['idKviza'] == kvizId) {
            final deleteUrl = Uri.parse('$prijaveUrl/$key.json?auth=$token');
            await http.delete(deleteUrl);
          }
        });
      }
    } else {
      throw Exception('Neuspešno učitavanje prijava');
    }
  }

  // Dobijanje lokacije
  Future<Lokacija> getLokacija(String lokacijaId, String token) async {
    final response = await http.get(Uri.parse('$lokacijeUrl/$lokacijaId.json?auth=$token'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return Lokacija.fromMap(data, lokacijaId);
    } else {
      throw Exception('Neuspešno učitavanje lokacije');
    }
  }

  
}
