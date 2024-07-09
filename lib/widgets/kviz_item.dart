import 'package:flutter/material.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/models/Lokacija.dart';
import 'package:pab_kviz/models/kviz.dart';
import 'package:pab_kviz/pages/prijava.dart';
import 'package:pab_kviz/pages/update_kviz_page.dart';
import 'package:pab_kviz/services/kviz_service.dart';

class KvizItem extends StatelessWidget {
  final Kviz kviz;
  final bool isAdmin;
  final Korisnik user;
  final String token;

  KvizItem({
    required this.kviz,
    required this.isAdmin,
    required this.user,
    required this.token,
  });

  Future<Lokacija> _fetchLokacija() async {
    KvizService service = KvizService();
    return await service.getLokacija(kviz.lokacijaId, token);
  }

  void _confirmDelete(BuildContext context) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Potvrda'),
          content: const Text('Da li ste sigurni da želite da obrišete ovaj kviz?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Ne'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Da'),
            ),
          ],
        );
      },
    );
    if (confirmed) {
      _deleteKviz(context);
    }
  }

  void _deleteKviz(BuildContext context) async {
    KvizService service = KvizService();
    try {
      await service.deleteKviz(kviz.id!, token);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Kviz obrisan uspešno!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Greška pri brisanju kviza!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Lokacija>(
      future: _fetchLokacija(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Lokacija nije pronađena'));
        } else {
          Lokacija lokacija = snapshot.data!;
          return Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kviz.naziv,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text('Datum: ${kviz.datum}'),
                  Text('Vreme: ${kviz.vreme}'),
                  Text('Cena po igraču: ${kviz.cenaPoIgracu} RSD'),
                  Text('Slobodna mesta: ${kviz.brojSlobodnihMesta}'),
                  Text('Naziv lokala: ${lokacija.naziv}'),
                  Text('Adresa: ${lokacija.adresa}'),
                  const SizedBox(height: 10),
                  if (isAdmin) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateKvizPage(user: user, kviz: kviz),
                            ),
                          ),
                          child: const Text('Ažuriraj'),
                        ),
                        TextButton(
                          onPressed: () => _confirmDelete(context),
                          child: const Text('Obriši'),
                        ),
                      ],
                    ),
                  ] else if (kviz.brojSlobodnihMesta == 0) ...[
                    const Center(
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
                        child: const Text('Prijavi ekipu'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
