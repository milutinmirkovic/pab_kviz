import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pab_kviz/pages/lokacija_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => LocationScreen(), // Privremeno pokrenite LocationScreen
    },
  ));
}
