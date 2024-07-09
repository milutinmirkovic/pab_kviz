import 'package:flutter/material.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/models/kviz.dart';
import 'package:pab_kviz/models/kategorija_kviza.dart';
import 'package:pab_kviz/services/kviz_service.dart';
import 'package:pab_kviz/services/kategorija_kviza_service.dart';
import 'package:pab_kviz/widgets/kategorija_item.dart';
import 'package:pab_kviz/widgets/navbar.dart';
import 'package:pab_kviz/widgets/drawer.dart';

class KvizoviPage extends StatefulWidget {
  final Korisnik user;

  KvizoviPage({required this.user});

  @override
  _KvizoviPageState createState() => _KvizoviPageState();
}

class _KvizoviPageState extends State<KvizoviPage> {
  final KategorijaKvizaService _kategorijaKvizaService = KategorijaKvizaService();
  final KvizService _kvizService = KvizService();

  late Future<List<KategorijaKviza>> _kategorijeFuture;
  late Future<List<Kviz>> _kvizoviFuture;

  @override
  void initState() {
    super.initState();
    _kategorijeFuture = _kategorijaKvizaService.getKategorije(widget.user.token!);
    _kvizoviFuture = _kvizService.getKvizovi(widget.user.token!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: 'Kvizovi', user: widget.user),
      drawer: CustomDrawer(user: widget.user),
      body: FutureBuilder<List<KategorijaKviza>>(
        future: _kategorijeFuture,
        builder: (context, kategorijeSnapshot) {
          if (kategorijeSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (kategorijeSnapshot.hasError) {
            return Center(child: Text('Error: ${kategorijeSnapshot.error}'));
          } else if (!kategorijeSnapshot.hasData || kategorijeSnapshot.data!.isEmpty) {
            return const Center(child: Text('Nema dostupnih kategorija'));
          } else {
            return FutureBuilder<List<Kviz>>(
              future: _kvizoviFuture,
              builder: (context, kvizoviSnapshot) {
                if (kvizoviSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (kvizoviSnapshot.hasError) {
                  return Center(child: Text('Error: ${kvizoviSnapshot.error}'));
                } else {
                  List<KategorijaKviza> kategorije = kategorijeSnapshot.data!;
                  List<Kviz> kvizovi = kvizoviSnapshot.data ?? [];

                  return ListView(
                    children: kategorije.map((kategorija) {
                      List<Kviz> kategorijaKvizovi = kvizovi.where((kviz) => kviz.tip == kategorija.id).toList();
                      return KategorijaItem(
                        kategorija: kategorija,
                        kvizovi: kategorijaKvizovi,
                        user: widget.user,
                      );
                    }).toList(),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
