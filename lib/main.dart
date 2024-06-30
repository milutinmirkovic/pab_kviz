import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/services/auth.dart';
import 'package:pab_kviz/wrapper.dart';
import 'package:pab_kviz/pages/lokacije_page.dart';


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

    runApp(MyApp());
  } catch (e) {
    print("Error initializing Firebase: ${e.toString()}");
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Korisnik?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
        routes: {
          //'/kvizovi': (context) => KvizoviPage(user: Provider.of<Korisnik>(context)!),
          '/lokacije': (context) => LokacijePage(user: Provider.of<Korisnik>(context)!),
        //  '/prijava': (context) => PrijavaPage(user: Provider.of<Korisnik>(context)!),
          // Dodajte ovde ostale rute prema potrebi
        },
      ),
    );
  }
}
