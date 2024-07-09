import 'package:flutter/material.dart';
import 'package:pab_kviz/pages/authenticate/register.dart';
import 'package:pab_kviz/pages/kreiraj_kviz_page.dart';
import 'package:pab_kviz/pages/kreiraj_lokaciju.dart';
import 'package:pab_kviz/pages/kvizovi_page.dart';
import 'package:pab_kviz/pages/lokacije_page.dart';
import 'package:pab_kviz/pages/pregled_kvizova.dart';
import 'package:pab_kviz/pages/prijava.dart';
import 'package:pab_kviz/pages/update_kviz_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/services/auth.dart';
import 'package:pab_kviz/pages/authenticate/sign_in.dart';
import 'package:pab_kviz/pages/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
       apiKey: "AIzaSyBmEVH20wKrwvDUsY_q_vijhBjXciWiB2Q",
        appId: "1:153624684587:android:abc123def456",
        messagingSenderId: "153624684587",
        projectId: "organizacija-pab-kvizova",
      ),
    );

    WidgetsFlutterBinding.ensureInitialized();
    await Korisnik.loadFromPreferences();
    runApp(MyApp());
  } catch (e) {
    print("Error initializing Firebase: ${e.toString()}");
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Korisnik.getCurrentUser() == null ? '/' : '/home',
      onGenerateRoute: (settings) {
        if (settings.name == '/napravi_prijavu') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return PrijavaPage(
                user: args['user'], 
                kviz: args['kviz'],
              );
            },
          );
        }else if (settings.name == '/update_kviz') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return UpdateKvizPage(
                user: args['user'],
                kviz: args['kviz'],
              );
            },
          );
        }
        
        return null;
      },
      routes: {
        '/': (context) => SignIn(),
        '/register': (context) => Register(),
        '/home': (context) => Home(),
        '/lokacije': (context) => LokacijePage(),
        '/tipovi_kvizova': (context) => KvizoviPage(),
        '/kreiraj_kviz': (context) => AddKvizPage(),
        '/kreiraj_lokaciju': (context) => CreateLokacijaPage(),
        //'/napravi_prijavu': (context) => PrijavaPage(user: Korisnik.getCurrentUser(),kviz: null),
        //'/update_quiz': (context) => UpdateKvizPage(),
        '/pregled_kvizova': (context) => PregledKvizovaPage(),
      },
    );
  }
}
