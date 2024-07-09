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
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if ( lokacija.slika.isNotEmpty)
              Image.asset(
                'assets/${lokacija.slika}', 
                width: double.infinity,
                height: 400,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox.shrink(); 
                },
              ),
            const SizedBox(height: 10),
            Text(
              lokacija.naziv,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(lokacija.opis),
            const SizedBox(height: 10),
            Text('Adresa: ${lokacija.adresa}'),
            const SizedBox(height: 10),
            const Text(
              'Kvizovi na ovoj lokaciji:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            if (kvizovi.isEmpty)
              const Text('Nema predstojećih kvizova'),
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
