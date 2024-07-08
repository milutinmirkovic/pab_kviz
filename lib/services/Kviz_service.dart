import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/models/Lokacija.dart';
import 'package:pab_kviz/models/kviz.dart';
import 'package:pab_kviz/models/PrijavaModel.dart';

class KvizService {
  final String baseUrl = 'https://organizacija-pab-kvizova-default-rtdb.europe-west1.firebasedatabase.app/kvizovi';
  final String prijaveUrl = 'https://organizacija-pab-kvizova-default-rtdb.europe-west1.firebasedatabase.app/prijave';
  final String lokacijeUrl = 'https://organizacija-pab-kvizova-default-rtdb.europe-west1.firebasedatabase.app/lokacije';

  Future<void> updateMesta(String kvizId, int currentBrojSlobodnihIgraca, String token) async {
    final url = Uri.parse('$baseUrl/$kvizId.json?auth=$token');
    final updatedBrojSlobodnihIgraca = currentBrojSlobodnihIgraca - 1;

    try {
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'brojSlobodnihMesta': updatedBrojSlobodnihIgraca}),
      );

      if (response.statusCode == 200) {
        print('Kviz updated successfully');
      } else {
        print('Failed to update kviz. Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception occurred while updating kviz: $e');
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
  Future<List<Prijava>> getPrijaveZaKviz(String kvizId, String token) async {
    final response = await http.get(Uri.parse('$prijaveUrl.json?auth=$token&orderBy="idKviza"&equalTo="$kvizId"'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<Prijava> prijave = [];
      data.forEach((key, value) {
        Prijava prijava = Prijava(
        
          teamName: value['teamName'],
          numPlayers: value['numPlayers'],
          emailUser: value['emailUser'],
          idKviza: value['idKviza'],
          kotizacija: value['kotizacija'],
        );
        prijave.add(prijava);
      });
      return prijave;
    } else {
      throw Exception('Failed to load prijave');
    }
  }

  Future<void> deletePrijava(String prijavaId, String token) async {
    final url = Uri.parse('$prijaveUrl/$prijavaId.json?auth=$token');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        print('Prijava deleted successfully');
      } else {
        print('Failed to delete prijava. Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception occurred while deleting prijava: $e');
    }
  }

  Future<void> deleteKviz(String kvizId, String token) async {
    final url = Uri.parse('$baseUrl/$kvizId.json?auth=$token');
    try {
      await deletePrijaveZaKviz(kvizId, token);
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

  Future<void> deletePrijaveZaKviz(String kvizId, String token) async {
    final response = await http.get(Uri.parse('$prijaveUrl.json?auth=$token&orderBy="idKviza"&equalTo="$kvizId"'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      data.forEach((key, value) async {
        final deleteUrl = Uri.parse('$prijaveUrl/$key.json?auth=$token');
        await http.delete(deleteUrl);
      });
    } else {
      throw Exception('Failed to load prijave');
    }
  }

  Future<Lokacija> getLokacija(String lokacijaId, String token) async {
    final response = await http.get(Uri.parse('$lokacijeUrl/$lokacijaId.json?auth=$token'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return Lokacija.fromMap(data, lokacijaId);
    } else {
      throw Exception('Failed to load lokacija');
    }
  }

  Future<List<Kviz>> getKvizovi(String token) async {
    final response = await http.get(Uri.parse('$baseUrl.json?auth=$token'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<Kviz> kvizovi = [];
      data.forEach((key, value) {
        Kviz kviz = Kviz.fromMap(value, key);
        kvizovi.add(kviz);
      });
      return kvizovi;
    } else {
      throw Exception('Failed to load kvizovi');
    }
  }

  Future<void> updateKviz(Kviz kviz, String token) async {
    final url = Uri.parse('$baseUrl/${kviz.id}.json?auth=$token');
    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(kviz.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update kviz');
    }
  }

  Future<void> createKviz(Kviz kviz, String token) async {
    final url = Uri.parse('$baseUrl.json?auth=$token');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(kviz.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create kviz');
    }
  }
}
