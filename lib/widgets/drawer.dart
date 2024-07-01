import 'package:flutter/material.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/pages/lokacije_page.dart';

class CustomDrawer extends StatelessWidget {

final Korisnik? user;
CustomDrawer({required this.user});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 153, 0),
            ),
            child: Text(
              'PAB KVIZ 8x8',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LokacijePage(user: user)));
            },
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Prijavi ekipu'),
            onTap: () {
              Navigator.pushNamed(context, '/prijava');
            },
          ),
        ],
      ),
    );
  }
}
