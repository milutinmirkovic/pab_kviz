import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
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
              Navigator.pushNamed(context, '/lokacije');
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
