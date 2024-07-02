import 'package:flutter/material.dart';
import 'package:pab_kviz/models/kategorija_kviza.dart';
import 'package:pab_kviz/models/kviz.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/widgets/kviz_item.dart';

class KategorijaItem extends StatelessWidget {
  final KategorijaKviza kategorija;
  final List<Kviz> kvizovi;
  final Korisnik user;

  KategorijaItem({required this.kategorija, required this.kvizovi, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/${kategorija.slika}',
                  width: 350,
                  height: 350,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              kategorija.naziv,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(kategorija.opis),
            SizedBox(height: 10),
            Text(
              'Kvizovi u ovoj kategoriji:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            for (Kviz kviz in kvizovi)
              KvizItem(
                kviz: kviz,
                isAdmin: user.isAdmin,
                user: user,
                onDelete: () {
                  // Implement delete logic here
                },
                onUpdate: () {
                  // Implement update logic here
                },
              ),
          ],
        ),
      ),
    );
  }
}
