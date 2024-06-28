import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pab_kviz/services/kviz_service.dart';
import 'package:pab_kviz/services/lokacija_service.dart';
import 'package:pab_kviz/models/kviz.dart';
import 'package:pab_kviz/models/lokacija.dart';
import 'package:pab_kviz/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBmEVH20wKrwvDUsY_q_vijhBjXciWiB2Q",
        appId: "1:153624684587:android:abc123def456",
        messagingSenderId: "153624684587",
        projectId: "organizacija-pab-kvizova",
      ),
    );

    print("Firebase initialized successfully.");

    // Ispis svih kvizova u konzoli
    await printAllKvizovi();

    runApp(MyApp());
  } catch (e) {
    print("Error initializing Firebase: ${e.toString()}");
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(),
    );
  }
}

Future<void> printAllKvizovi() async {
  KvizService kvizService = KvizService();
  LokacijaService lokacijaService = LokacijaService();
  try {
    print("Fetching kvizovi...");
    List<Kviz> kvizovi = await kvizService.getKvizovi();
    List<Lokacija> lokacije = await lokacijaService.getLocations();

    // Mapa za brzo pronalaženje naziva lokacije prema ID-u
    Map<String, String> lokacijaMap = {
      for (var lokacija in lokacije) lokacija.id!: lokacija.naziv,
    };

    for (Kviz kviz in kvizovi) {
      String? lokacijaNaziv = lokacijaMap[kviz.lokacijaId];
      print('Kviz: ${kviz.naziv}, Tip: ${kviz.tip}, Vreme: ${kviz.vreme}, Cena po igracu: ${kviz.cenaPoIgracu}, Lokacija: ${lokacijaNaziv ?? kviz.lokacijaId}, Broj slobodnih mesta: ${kviz.brojSlobodnihMesta}');
    }
  } catch (e) {
    print('Failed to load kvizovi: $e');
  }
}

