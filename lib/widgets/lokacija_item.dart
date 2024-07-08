import 'package:flutter/material.dart';
import 'package:pab_kviz/models/lokacija.dart';
import 'package:pab_kviz/models/kviz.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/widgets/kviz_item.dart';

class LokacijaItem extends StatelessWidget {
  final Lokacija lokacija;
  final List<Kviz> kvizovi;
  final Korisnik user;

  LokacijaItem({required this.lokacija, required this.kvizovi, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/${lokacija.slika}', // Assuming lokacija.slika holds the image filename
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              lokacija.naziv,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(lokacija.opis),
            SizedBox(height: 10),
            Text('Adresa: ${lokacija.adresa}'),
            SizedBox(height: 10),
            Text(
              'Kvizovi na ovoj lokaciji:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            for (Kviz kviz in kvizovi)
              KvizItem(
                kviz: kviz,
                isAdmin: user.isAdmin,
                user: user,
                token: user.token ?? '',
              ),
          ],
        ),
      ),
    );
  }
}
