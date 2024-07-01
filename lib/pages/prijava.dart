import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/models/PrijavaModel.dart';
import 'package:pab_kviz/models/kviz.dart';
import 'package:pab_kviz/services/Kviz_service.dart';
import 'package:pab_kviz/services/prijava_service.dart';
import 'package:pab_kviz/widgets/drawer.dart';
import 'package:pab_kviz/widgets/navbar.dart';

class PrijavaPage extends StatelessWidget {
  PrijavaPage({super.key, required this.user, required this. kviz});
  final Korisnik? user;
  final Kviz? kviz;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _teamNameController = TextEditingController();
  TextEditingController _numPlayersController = TextEditingController();
  final PrijavaService prijavaService = PrijavaService();
  final KvizService kvizService = KvizService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: 'PAB KVIZ 8x8', user: user),
      drawer: CustomDrawer(user: user),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _teamNameController,
                decoration: InputDecoration(
                  labelText: 'Ime ekipe',
                  hintText: 'Unesite ime vaše ekipe',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Molimo vas unesite ime ekipe';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _numPlayersController,
                decoration: InputDecoration(
                  labelText: 'Broj igrača',
                  hintText: 'Unesite broj igrača u vašoj ekipi',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Molimo vas unesite broj igrača u vašoj ekipi';
                  }
                  // You can add additional validation if needed, e.g., numeric validation
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {

                  if(kviz?.brojSlobodnihMesta==0){
                    print("Nema slobodnih mesta!");
                  }else{

                    if (_formKey.currentState!.validate()) {
                    // Form is validated, proceed with your logic
                    // For now, you can print the values entered
                    String teamName = _teamNameController.text;
                    int numPlayers = int.parse(_numPlayersController.text);
                    print('Ime ekipe: $teamName, Broj igraca: $numPlayers');
                    Prijava prijava = Prijava(teamName: teamName, numPlayers: numPlayers, user: user, kviz: kviz);
                    prijavaService.createPrijava(prijava); 
                    kvizService.updateKviz(kviz!.id,kviz!.brojSlobodnihMesta,user!.token);
                    
                    
                  }

                  }


                  
                },
                child: Text('Prijavi ekipu'),
              ),
            ],
          ),
        ),
      ), 



      
      );
    
    }
  }
