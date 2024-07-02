import 'package:flutter/material.dart';
import 'package:pab_kviz/models/lokacija.dart';
import 'package:pab_kviz/models/kviz.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/pages/prijava.dart';

class LokacijaItem extends StatelessWidget {
  final Lokacija lokacija;
  final List<Kviz> kvizovi;
  final Korisnik? user;

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
            ...kvizovi.map((kviz) {
              return ListTile(
                title: Text(kviz.naziv),
                subtitle: Text(
                  'Datum: ${kviz.datum}\nVreme: ${kviz.vreme}\nCena po igraču: ${kviz.cenaPoIgracu} RSD\nBroj slobodnih mesta: ${kviz.brojSlobodnihMesta}',
                ),
                trailing: kviz.brojSlobodnihMesta > 0
                  ? ElevatedButton(
                      onPressed: () {
                        // Navigacija na prijavu
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrijavaPage(user: user, kviz: kviz),
                          ),
                        );
                      },
                      child: Text('Prijavi ekipu'),
                    )
                  : Text(
                      'Popunjeno',
                      style: TextStyle(color: Colors.red),
                    ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
