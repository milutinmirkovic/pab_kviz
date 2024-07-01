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
  final Korisnik? user; // Auth token

  LokacijePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: 'Lokacije', user: user),
      drawer: CustomDrawer(user: user),
      body: FutureBuilder<List<Lokacija>>(
        future: lokacijaService.getLocations(user!.token ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No locations found'));
          } else {
            List<Lokacija> lokacije = snapshot.data!;
            return ListView(
              children: lokacije.map((lokacija) {
                return FutureBuilder<List<Kviz>>(
                  future: kvizService.getKvizovi(user!.token ?? ''),
                  builder: (context, kvizSnapshot) {
                    if (kvizSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (kvizSnapshot.hasError) {
                      return Center(child: Text('Error: ${kvizSnapshot.error}'));
                    } else if (!kvizSnapshot.hasData || kvizSnapshot.data!.isEmpty) {
                      return LokacijaItem(lokacija: lokacija, kvizovi: []);
                    } else {
                      List<Kviz> kvizovi = kvizSnapshot.data!.where((kviz) => kviz.lokacijaId == lokacija.id).toList();
                      return LokacijaItem(lokacija: lokacija, kvizovi: kvizovi);
                    }
                  },
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
