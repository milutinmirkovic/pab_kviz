import 'package:flutter/material.dart';
import 'package:pab_kviz/services/kviz_service.dart';
import 'package:pab_kviz/models/kviz.dart';
import 'package:pab_kviz/widgets/navbar.dart';
import 'package:pab_kviz/widgets/drawer.dart';
import 'package:pab_kviz/widgets/kviz_item.dart';
import 'package:pab_kviz/models/Korisnik.dart';

class Home extends StatelessWidget {
  final KvizService kvizService = KvizService();
  final Korisnik user; // Auth token

  Home({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: 'PAB KVIZ 8x8', user: user),
      drawer: CustomDrawer(),
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
                  fit: BoxFit.cover, // This will make the image cover the entire width
                  height: 300, // Adjust the height as needed
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
                for (Kviz kviz in kvizovi.take(3)) // Display only next 3 quizzes
                  KvizItem(
                    kviz: kviz,
                    isAdmin: user.isAdmin,
                    onDelete: () {
                      // Implement delete logic here
                    },
                    onUpdate: () {
                      // Implement update logic here
                    },
                    onRegister: () {
                      // Implement registration logic here
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
