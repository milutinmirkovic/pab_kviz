import 'package:flutter/material.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/models/PrijavaModel.dart';
import 'package:pab_kviz/models/kviz.dart';
import 'package:pab_kviz/services/Kviz_service.dart';
import 'package:pab_kviz/services/prijava_service.dart';
import 'package:pab_kviz/widgets/drawer.dart';
import 'package:pab_kviz/widgets/navbar.dart';

class PrijavaPage extends StatelessWidget {
  PrijavaPage({super.key, required this.user, required this.kviz});
  final Korisnik? user;
  final Kviz? kviz;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PrijavaService prijavaService = PrijavaService();
  final KvizService kvizService = KvizService();
  String? imeEkipe;
  int? brojIgraca;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: 'PAB KVIZ 8x8', user: user),
      drawer: CustomDrawer(user: user),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Ime ekipe',
                  hintText: 'Unesite ime vaše ekipe',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Molimo vas unesite ime ekipe';
                  }
                  imeEkipe = value;
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Broj igrača',
                  hintText: 'Unesite broj igrača u vašoj ekipi (2-6)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Molimo vas unesite broj igrača u vašoj ekipi';
                  }
                  int? broj = int.tryParse(value);
                  if (broj == null || broj < 2 || broj > 6) {
                    return 'Broj igrača mora biti između 2 i 6';
                  }
                  brojIgraca = broj;
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if (kviz?.brojSlobodnihMesta == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Nema slobodnih mesta!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    if (_formKey.currentState!.validate()) {
                      Prijava prijava = Prijava(
                        teamName: imeEkipe!,
                        numPlayers: brojIgraca!.toDouble(),
                        emailUser: user!.email!,
                        idKviza: kviz!.id!,
                        kotizacija: brojIgraca! * kviz!.cenaPoIgracu,
                      );
                      await prijavaService.createPrijava(prijava, user!.token!);
                      await kvizService.updateMesta(kviz!.id!, kviz!.brojSlobodnihMesta, user!.token!);
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Uspešno ste se prijavili'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      // Resetuj formu nakon prijave
                      _formKey.currentState!.reset();
                    }
                  }
                },
                child: const Text('Prijavi ekipu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
