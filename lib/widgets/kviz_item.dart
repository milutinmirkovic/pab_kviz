import 'package:flutter/material.dart';
import 'package:pab_kviz/models/kviz.dart';
import 'package:pab_kviz/models/Korisnik.dart'; // Import Korisnik
import 'package:pab_kviz/pages/prijava.dart'; // Import prijava page

class KvizItem extends StatelessWidget {
  final Kviz kviz;
  final bool isAdmin;
  final Korisnik user; 
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  KvizItem({
    required this.kviz,
    required this.isAdmin,
    required this.user, 
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              kviz.naziv,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Datum: ${kviz.datum}'),
            Text('Vreme: ${kviz.vreme}'),
            Text('Cena po igraču: ${kviz.cenaPoIgracu} RSD'),
            Text('Slobodna mesta: ${kviz.brojSlobodnihMesta}'),
            SizedBox(height: 10),
            if (isAdmin) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onUpdate,
                    child: Text('Update'),
                  ),
                  TextButton(
                    onPressed: onDelete,
                    child: Text('Delete'),
                  ),
                ],
              ),
            ] else if (kviz.brojSlobodnihMesta == 0) ...[
              Center(
                child: Text(
                  'Popunjen',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ] else ...[
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrijavaPage(user: user, kviz: kviz),
                      ),
                    );
                  },
                  child: Text('Prijavi ekipu'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
