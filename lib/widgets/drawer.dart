import 'package:flutter/material.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/pages/lokacije_page.dart';
import 'package:pab_kviz/pages/kreiraj_kviz_page.dart';
import 'package:pab_kviz/pages/home/home.dart';

class CustomDrawer extends StatelessWidget {
  final Korisnik? user;
  CustomDrawer({required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 120,
            child: DrawerHeader(
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
            leading: Icon(Icons.home),
            title: Text('Početna'),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home(user: user!)));
            },
          ),
          ListTile(
            leading: Icon(Icons.quiz),
            title: Text('Kvizovi'),
            onTap: () {
              Navigator.pushNamed(context, '/kvizovi');
            },
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Lokacije'),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LokacijePage(user: user)));
            },
          ),
          if (user != null && user!.isAdmin) ...[
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Dodaj Kviz'),
               onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) =>  AddKvizPage(user: user)));
            },
            ),
            ListTile(
              leading: Icon(Icons.add_location),
              title: Text('Dodaj Lokaciju'),
              onTap: () {
                Navigator.pushNamed(context, '/dodajLokaciju'); // Ruta za stranicu za dodavanje lokacije
              },
            ),
          ],
        ],
      ),
    );
  }
}
