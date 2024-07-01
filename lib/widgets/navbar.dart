import 'package:flutter/material.dart';
import 'package:pab_kviz/pages/authenticate/sign_in.dart';
import 'package:pab_kviz/pages/home/home.dart'; // Importujte vašu početnu stranicu
import 'package:pab_kviz/services/auth.dart';
import 'package:pab_kviz/models/Korisnik.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final AuthService _auth = AuthService();
  final String title;
  final Korisnik? user;

  Navbar({required this.title, required this.user});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 255, 153, 0),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home(user: user!)),
              );
            },
            child: Image.asset('assets/logo.png', height: 30),
          ),
          SizedBox(width: 10),
          Text(title),
        ],
      ),
      actions: <Widget>[
        TextButton.icon(
          icon: Icon(Icons.person),
          label: Text('Logout'),
          onPressed: () async {
            await _auth.signOut();
            // Navigate to SignIn page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignIn()),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
