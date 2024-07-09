import 'package:flutter/material.dart';
import 'package:pab_kviz/models/Korisnik.dart';
//import 'package:pab_kviz/pages/kreiraj_lokaciju.dart';
//import 'package:pab_kviz/pages/lokacije_page.dart';
//import 'package:pab_kviz/pages/kreiraj_kviz_page.dart';
//import 'package:pab_kviz/pages/home/home.dart';
//import 'package:pab_kviz/pages/kvizovi_page.dart';
//import 'package:pab_kviz/pages/pregled_kvizova.dart'; 

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
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.quiz),
            title: const Text('Kvizovi'),
            onTap: () {
              Navigator.pushNamed(context, '/tipovi_kvizova');
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Lokacije'),
            onTap: () {
              Navigator.pushNamed(context, '/lokacije');
            },
          ),
          if (user != null && user!.isAdmin) ...[ //ako je uslov tacan, dodaj u listu sledece, nakon tackica
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Dodaj Kviz'),
              onTap: () {
                Navigator.pushNamed(context, '/kreiraj_kviz');
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_location),
              title: const Text('Dodaj Lokaciju'),
              onTap: () {
                Navigator.pushNamed(context, '/kreiraj_lokaciju');
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Pregled Kvizova'), 
              onTap: () {
                Navigator.pushNamed(context, '/pregled_kvizova');
              },
            ),
          ],
        ],
      ),
    );
  }
}
