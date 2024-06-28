import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/services/auth.dart';
import 'package:pab_kviz/wrapper.dart';
import 'package:provider/provider.dart';
//import 'pages/login_page.dart';

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
      ),
    );
  }
}