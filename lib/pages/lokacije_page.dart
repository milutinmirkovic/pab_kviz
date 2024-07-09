import 'package:flutter/material.dart';
import 'package:pab_kviz/services/lokacija_service.dart';
import 'package:pab_kviz/services/kviz_service.dart';
import 'package:pab_kviz/models/lokacija.dart';
import 'package:pab_kviz/models/kviz.dart';
import 'package:pab_kviz/widgets/lokacija_item.dart';
import 'package:pab_kviz/widgets/navbar.dart';
import 'package:pab_kviz/widgets/drawer.dart';
import 'package:pab_kviz/models/Korisnik.dart';

class LokacijePage extends StatelessWidget {
  final LokacijaService lokacijaService = LokacijaService();
  final KvizService kvizService = KvizService();
  final Korisnik? user=Korisnik.getCurrentUser();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: 'Lokacije', user: user),
      drawer: CustomDrawer(user: user),
      body: FutureBuilder(
        future: Future.wait([
          lokacijaService.getLocations(user!.token ?? ''),
          kvizService.getKvizovi(user!.token ?? ''),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Greška: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nema podataka'));
            } else {
              List<Lokacija> lokacije = snapshot.data![0] as List<Lokacija>;
              List<Kviz> kvizovi = snapshot.data![1] as List<Kviz>;
              
              return ListView(

                children: lokacije.map((lokacija) {

                  List<Kviz> lokacijaKvizovi = kvizovi.where((kviz) => kviz.lokacijaId == lokacija.id).toList();

                  return LokacijaItem(user: user!, lokacija: lokacija, kvizovi: lokacijaKvizovi);
                  
                }).toList(),
              );
            }
          } else {
            return const Center(child: const CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
