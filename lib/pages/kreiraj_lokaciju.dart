import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/models/lokacija.dart';
import 'package:pab_kviz/services/lokacija_service.dart';
import 'package:pab_kviz/widgets/drawer.dart';
import 'package:pab_kviz/widgets/navbar.dart';


class CreateLokacijaPage extends StatefulWidget {
  @override

  final Korisnik? user;
  CreateLokacijaPage({required this.user});
  _CreateLokacijaPageState createState() => _CreateLokacijaPageState(user: user);
}

class _CreateLokacijaPageState extends State<CreateLokacijaPage> {
  final _formKey = GlobalKey<FormState>();
  final LokacijaService lokacijaService = LokacijaService();


  _CreateLokacijaPageState({required this.user});
  final Korisnik? user;
  

  String adresa = '';
  int kapacitet = 0;
  String naziv = '';
  String opis = '';
  String slika = '';

  @override
  Widget build(BuildContext context) {
    final String? authToken = user!.token;
    print(authToken);
    return Scaffold(
      appBar: Navbar(title: 'PAB KVIZ 8x8', user: user),
      drawer: CustomDrawer(user: user),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Adresa'),
                validator: (value) => value!.isEmpty ? 'Unesite adresu' : null,
                onChanged: (value) {
                  setState(() {
                    adresa = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Kapacitet'),
                validator: (value) => value!.isEmpty ? 'Unesite kapacitet' : null,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    kapacitet = int.tryParse(value) ?? 0;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Naziv'),
                validator: (value) => value!.isEmpty ? 'Unesite naziv' : null,
                onChanged: (value) {
                  setState(() {
                    naziv = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Opis'),
                validator: (value) => value!.isEmpty ? 'Unesite opis' : null,
                onChanged: (value) {
                  setState(() {
                    opis = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Slika'),
                validator: (value) => value!.isEmpty ? 'Unesite putanju ka slici' : null,
                onChanged: (value) {
                  setState(() {
                    slika = value;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Get the auth token
                    User? user = FirebaseAuth.instance.currentUser;
                    String? authToken = await user?.getIdToken();

                    if (authToken != null) {
                      Lokacija newLokacija = Lokacija(
                        adresa: adresa,
                        kapacitet: kapacitet,
                        naziv: naziv,
                        opis: opis,
                        slika: slika,
                      );
                      await lokacijaService.createLokacija(newLokacija, authToken);
                       ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Uspešno ste se prijavili'),
                          backgroundColor: Colors.green,
                        ),
                      );
                     
                    } else {
                      print('Failed to get auth token.');
                    }
                  }
                },
                child: const Text('Dodajte lokaciju'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
