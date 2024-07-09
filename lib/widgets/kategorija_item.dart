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
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16),
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
            const SizedBox(height: 10),
            Text(
              kategorija.naziv,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(kategorija.opis),
            const SizedBox(height: 10),
            const Text(
              'Kvizovi u ovoj kategoriji:',
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
