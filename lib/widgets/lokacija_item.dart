import 'package:flutter/material.dart';
import 'package:pab_kviz/models/lokacija.dart';
import 'package:pab_kviz/models/kviz.dart';

class LokacijaItem extends StatelessWidget {
  final Lokacija lokacija;
  final List<Kviz> kvizovi;

  LokacijaItem({required this.lokacija, required this.kvizovi});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Align center
          children: [
            Text(
              lokacija.naziv.toUpperCase(),
              style: TextStyle(
                fontSize: 30, // Increase font size
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 153, 0), // Orange color
              ),
              textAlign: TextAlign.center, // Center text
            ),
            SizedBox(height: 10),
            Image.asset(
              'assets/${lokacija.slika}', 
              width: double.infinity,
              height: 400,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              lokacija.opis,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center, // Center text
            ),
            SizedBox(height: 10),
            Text(
              lokacija.adresa,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center, // Center text
            ),
            SizedBox(height: 10),
            Text(
              'Kvizovi na ovoj lokaciji:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center, // Center text
            ),
            ...kvizovi.map((kviz) {
              return ListTile(
                title: Text(kviz.naziv),
                subtitle: Text(
                  'Datum: ${kviz.datum}\nVreme: ${kviz.vreme}\nCena po igraču: ${kviz.cenaPoIgracu} RSD',
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Navigacija na detalje kviza
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
