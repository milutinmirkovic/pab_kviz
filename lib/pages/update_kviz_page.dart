import 'package:flutter/material.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/models/kviz.dart';
import 'package:pab_kviz/services/kviz_service.dart';
import 'package:pab_kviz/widgets/navbar.dart';
import 'package:pab_kviz/widgets/drawer.dart';

class UpdateKvizPage extends StatefulWidget {
  final Korisnik user;
  final Kviz kviz;

  UpdateKvizPage({required this.user, required this.kviz});

  @override
  _UpdateKvizPageState createState() => _UpdateKvizPageState();
}

class _UpdateKvizPageState extends State<UpdateKvizPage> {
  final _formKey = GlobalKey<FormState>();

  String naziv = '';
  String datum = '';
  String vreme = '';
  String cenaPoIgracu = '';
  String brojSlobodnihMesta = '';

  @override
  void initState() {
    super.initState();
    naziv = widget.kviz.naziv;
    datum = widget.kviz.datum;
    vreme = widget.kviz.vreme;
    cenaPoIgracu = widget.kviz.cenaPoIgracu.toString();
    brojSlobodnihMesta = widget.kviz.brojSlobodnihMesta.toString();
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
      appBar: Navbar(title: 'Ažuriraj Kviz', user: widget.user),
      drawer: CustomDrawer(user: widget.user),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  initialValue: naziv,
                  decoration: const InputDecoration(labelText: 'Naziv'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unesite naziv kviza';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    naziv = value!;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  initialValue: datum,
                  decoration: const InputDecoration(labelText: 'Datum'),
                  validator: _validateDate,
                  onSaved: (value) {
                    datum = value!;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  initialValue: vreme,
                  decoration: const InputDecoration(labelText: 'Vreme'),
                  validator: _validateTime,
                  onSaved: (value) {
                    vreme = value!;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  initialValue: cenaPoIgracu,
                  decoration: const InputDecoration(labelText: 'Cena po igraču'),
                  keyboardType: TextInputType.number,
                  validator: _validatePrice,
                  onSaved: (value) {
                    cenaPoIgracu = value!;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  initialValue: brojSlobodnihMesta,
                  decoration: const InputDecoration(labelText: 'Broj slobodnih mesta'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unesite broj slobodnih mesta';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    brojSlobodnihMesta = value!;
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _updateKviz();
                    }
                  },
                  child: const Text('Ažuriraj Kviz'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateKviz() async {
    Kviz updatedKviz = Kviz(
      id: widget.kviz.id,
      naziv: naziv,
      datum: datum,
      vreme: vreme,
      cenaPoIgracu: double.parse(cenaPoIgracu),
      lokacijaId: widget.kviz.lokacijaId,
      brojSlobodnihMesta: int.parse(brojSlobodnihMesta),
      ucesca: widget.kviz.ucesca,
      tip: widget.kviz.tip,
    );

    try {
      await KvizService().updateKviz(updatedKviz, widget.user.token!);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Kviz uspešno ažuriran!')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Greška pri ažuriranju kviza!')));
    }
  }
}
