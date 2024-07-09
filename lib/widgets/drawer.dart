import 'package:flutter/material.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/pages/kreiraj_lokaciju.dart';
import 'package:pab_kviz/pages/lokacije_page.dart';
import 'package:pab_kviz/pages/kreiraj_kviz_page.dart';
import 'package:pab_kviz/pages/home/home.dart';
import 'package:pab_kviz/pages/kvizovi_page.dart';
import 'package:pab_kviz/pages/pregled_kvizova.dart'; 

class CustomDrawer extends StatelessWidget {
  final Korisnik? user;
  const CustomDrawer({required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 120,
            child: const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 153, 0),
              ),
              child: Center(
                child: Text(
                  'PAB KVIZ 8x8',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Početna'),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home(user: user!)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.quiz),
            title: const Text('Kvizovi'),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => KvizoviPage(user: user!)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Lokacije'),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LokacijePage(user: user)));
            },
          ),
          if (user != null && user!.isAdmin) ...[
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Dodaj Kviz'),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => AddKvizPage(user: user)));
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_location),
              title: const Text('Dodaj Lokaciju'),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => CreateLokacijaPage(user: user)));
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Pregled Kvizova'), 
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => PregledKvizovaPage(user: user!))); // Navigacija na stranicu Pregled Kvizova
              },
            ),
          ],
        ],
      ),
    );
  }
}
