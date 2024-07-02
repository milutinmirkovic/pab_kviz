import 'package:flutter/material.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/models/kviz.dart';
import 'package:pab_kviz/services/kviz_service.dart';
import 'package:pab_kviz/widgets/navbar.dart';
import 'package:pab_kviz/widgets/drawer.dart';
import 'package:pab_kviz/widgets/kviz_item.dart';

class Home extends StatelessWidget {
  final KvizService kvizService = KvizService();
  final Korisnik user;

  Home({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: 'PAB KVIZ 8x8', user: user),
      drawer: CustomDrawer(user: user),
      body: FutureBuilder<List<Kviz>>(
        future: kvizService.getKvizovi(user.token ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No upcoming quizzes found'));
          } else {
            List<Kviz> kvizovi = snapshot.data!;
            return ListView(
              children: [
                Image.asset(
                  'assets/kviz.jpeg',
                  fit: BoxFit.cover, 
                  height: 300, 
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Pab kviz koncept',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 153, 0),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Pab kviz 8×8 je koncept zabave gde se ljudi mogu u opuštenoj atmosferi, uz klopu i piće, takmičiti sa svojim prijateljima protiv drugih ekipa i osvojiti nagrade. Odgovori se predaju u pismenoj formi, stoga svi koji imaju strah od javnog nastupa nemaju razloga za brigu. Ekipe su sastavljene od određenog broja članova, koji se okupljaju u nekom od kafića (pabova) gde se nadmeću u znanju na zadatu temu.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    'Najave za naredne kvizove',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 255, 153, 0),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                for (Kviz kviz in kvizovi.take(3))
                  KvizItem(
                    kviz: kviz,
                    isAdmin: user.isAdmin,
                    user: user, // Pass user to KvizItem
                    onDelete: () {
                      // Implement delete logic here
                    },
                    onUpdate: () {
                      // Implement update logic here
                    },
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
