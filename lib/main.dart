import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/services/auth.dart';
import 'package:pab_kviz/wrapper.dart';
import 'package:provider/provider.dart';
//import 'pages/login_page.dart';


void main() async{
  try{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: "AIzaSyBmEVH20wKrwvDUsY_q_vijhBjXciWiB2Q",
      appId: "com.organizacija.pab_kviz",
      messagingSenderId: "153624684587",
      projectId: "organizacija-pab-kvizova",),);
  runApp(MyApp());
  }catch(e){
    print(e.toString());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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