import 'package:flutter/material.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/models/kviz.dart';
import 'package:pab_kviz/models/PrijavaModel.dart';
import 'package:pab_kviz/services/kviz_service.dart';
import 'package:pab_kviz/widgets/navbar.dart';
import 'package:pab_kviz/widgets/drawer.dart';

class PregledKvizovaPage extends StatelessWidget {
  final Korisnik user;
  final KvizService kvizService = KvizService();

  PregledKvizovaPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: 'Pregled Kvizova', user: user),
      drawer: CustomDrawer(user: user),
      body: FutureBuilder<List<Kviz>>(
        future: kvizService.getKvizovi(user.token!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Kvizovi nisu pronađeni'));
          } else {
            List<Kviz> kvizovi = snapshot.data!;
            return ListView.builder(
              itemCount: kvizovi.length,
              itemBuilder: (context, index) {
                return KvizCard(kviz: kvizovi[index], user: user);
              },
            );
          }
        },
      ),
    );
  }
}

class KvizCard extends StatelessWidget {
  final Kviz kviz;
  final Korisnik user;
  final KvizService kvizService = KvizService();

  KvizCard({required this.kviz, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(16),
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
            SizedBox(height: 10),
            FutureBuilder<List<Prijava>>(
              future: kvizService.getPrijaveZaKviz(kviz.id!, user.token!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Prijave nisu pronađene'));
                } else {
                  List<Prijava> prijave = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Broj prijavljenih ekipa: ${prijave.length}'),
                      Text('Broj preostalih mesta: ${kviz.brojSlobodnihMesta}'),
                      Text('Prihod od kotizacija: ${prijave.fold(0.0, (total, prijava) => total + prijava.kotizacija)} RSD'),
                      Text('Ukupno ljudi: ${prijave.fold(0, (total, prijava) => total + prijava.numPlayers)}'),
                      Divider(),
                      ...prijave.map((prijava) {
                        return ListTile(
                          title: Text(prijava.teamName),
                          subtitle: Text(prijava.emailUser),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              bool success = await kvizService.deletePrijava(prijava.id!, user.token!);
                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Prijava uspešno obrisana'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                await kvizService.updateMesta(kviz.id!, kviz.brojSlobodnihMesta + 1, user.token!);
                                (context as Element).reassemble();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Brisanje prijave nije uspelo'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
