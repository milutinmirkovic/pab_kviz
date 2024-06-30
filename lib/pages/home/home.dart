import 'package:flutter/material.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/services/kviz_service.dart';
import 'package:pab_kviz/models/kviz.dart';
import 'package:pab_kviz/services/auth.dart';

class Home extends StatelessWidget {
  

   final AuthService _auth = AuthService();

   final Korisnik user;
   Home({super.key, required this.user});
   KvizService kvizService = new KvizService(); 
   

  @override
  Widget build(BuildContext context) {
    
    print(user.email);
    print(user.token);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 153, 0),
        centerTitle: true,
        title: Image.asset(
          'assets/logo.png',
          height: 100, 
        ),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 153, 0),
              ),
              child: Text(
                'PAB KVIZ 8x8',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.quiz),
              title: Text('Kvizovi'),
              onTap: () {
                Navigator.pushNamed(context, '/kvizovi');
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Lokacije'),
              onTap: () {
                Navigator.pushNamed(context, '/lokacije');
              },
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Prijavi ekipu'),
              onTap: () {
                Navigator.pushNamed(context, '/prijava');
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Kviz>>(
        future: kvizService.getKvizovi(),
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Najave za naredne kvizove',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                for (Kviz kviz in kvizovi.take(3)) // Display only next 3 quizzes
                  ListTile(
                    title: Text(kviz.naziv),
                    subtitle: Text(
                      'Datum: ${kviz.datum}\nVreme: ${kviz.vreme}\nCena po igraču: ${kviz.cenaPoIgracu} RSD',
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
