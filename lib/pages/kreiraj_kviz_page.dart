import 'package:flutter/material.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/models/kviz.dart';
import 'package:pab_kviz/models/lokacija.dart';
import 'package:pab_kviz/models/kategorija_kviza.dart';
import 'package:pab_kviz/services/kviz_service.dart';
import 'package:pab_kviz/services/lokacija_service.dart';
import 'package:pab_kviz/services/kategorija_kviza_service.dart';
import 'package:pab_kviz/shared/constants.dart';
import 'package:pab_kviz/widgets/navbar.dart';
import 'package:pab_kviz/widgets/drawer.dart';

class AddKvizPage extends StatefulWidget {
  final Korisnik? user;

  AddKvizPage({required this.user});

  @override
  _AddKvizPageState createState() => _AddKvizPageState();
}

class _AddKvizPageState extends State<AddKvizPage> {
  final _formKey = GlobalKey<FormState>();
  final KvizService _kvizService = KvizService();
  final LokacijaService _lokacijaService = LokacijaService();
  final KategorijaKvizaService _kategorijaKvizaService = KategorijaKvizaService();

  String naziv = '';
  String tip = '';
  String vreme = '';
  String datum = '';
  double cenaPoIgracu = 0.0;
  String lokacijaId = '';
  int brojSlobodnihMesta = 0;
  List<String> ucesca = [];

  List<Lokacija> lokacije = [];
  List<KategorijaKviza> tipoviKviza = [];

  @override
  void initState() {
    super.initState();
    _loadLokacije();
    _loadTipoviKviza();
  }

  void _loadLokacije() async {
    if (widget.user!.token != null) {
      try {
        List<Lokacija> loadedLokacije = await _lokacijaService.getLocations(widget.user!.token!);
        setState(() {
          lokacije = loadedLokacije;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Greška prilikom učitavanja lokacija: $e")),
        );
      }
    }
  }

  void _loadTipoviKviza() async {
    if (widget.user!.token != null) {
      try {
        List<KategorijaKviza> loadedTipoviKviza = await _kategorijaKvizaService.getKategorije(widget.user!.token!);
        setState(() {
          tipoviKviza = loadedTipoviKviza;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Greška prilikom učitavanja tipova kviza: $e")),
        );
      }
    }
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Unesite datum kviza';
    }
    final dateRegExp = RegExp(r'^\d{2}.\d{2}.\d{4}$');
    if (!dateRegExp.hasMatch(value)) {
      return 'Unesite datum u formatu dd.mm.yyyy';
    } 
    return null;
  }

  String? _validateTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'Unesite vreme kviza';
    }
    final timeRegExp = RegExp(r'^\d{2}:\d{2}$');
    if (!timeRegExp.hasMatch(value)) {
      return 'Unesite vreme u formatu HH:mm';
    }
    final parts = value.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    if (hours < 0 || hours > 23 || minutes < 0 || minutes > 59) {
      return 'Unesite ispravno vreme';
    }
    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Unesite cenu po igraču';
    }
    final price = double.tryParse(value);
    if (price == null) {
      return 'Cena mora biti broj';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: 'Dodaj Kviz', user: widget.user),
      drawer: CustomDrawer(user: widget.user),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Naziv'),
                  validator: (val) => val!.isEmpty ? 'Unesite naziv kviza' : null,
                  onChanged: (val) {
                    setState(() => naziv = val);
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: textInputDecoration.copyWith(hintText: 'Tip kviza'),
                  items: tipoviKviza.map((KategorijaKviza tip) {
                    return DropdownMenuItem<String>(
                      value: tip.id,
                      child: Text(tip.naziv),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() => tip = val!);
                  },
                  validator: (val) => val == null ? 'Odaberite tip kviza' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Vreme'),
                  validator: _validateTime,
                  onChanged: (val) {
                    setState(() => vreme = val);
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Datum'),
                  validator: _validateDate,
                  onChanged: (val) {
                    setState(() => datum = val);
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Cena po igraču'),
                  validator: _validatePrice,
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setState(() => cenaPoIgracu = double.parse(val));
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: textInputDecoration.copyWith(hintText: 'Lokacija'),
                  items: lokacije.map((Lokacija lokacija) {
                    return DropdownMenuItem<String>(
                      value: lokacija.id,
                      child: Text(lokacija.naziv),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      lokacijaId = val!;
                      brojSlobodnihMesta = lokacije.firstWhere((lok) => lok.id == val).kapacitet;
                    });
                  },
                  validator: (val) => val == null ? 'Odaberite lokaciju' : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: const Text(
                    'Dodaj Kviz',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Kviz newKviz = Kviz(
                        naziv: naziv,
                        tip: tip,
                        vreme: vreme,
                        datum: datum,
                        cenaPoIgracu: cenaPoIgracu,
                        lokacijaId: lokacijaId,
                        brojSlobodnihMesta: brojSlobodnihMesta,
                        ucesca: [],
                      );
                      await _kvizService.insertKviz(newKviz, widget.user!.token!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Kviz uspešno dodat'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
