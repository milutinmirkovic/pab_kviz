import 'package:flutter/material.dart';
//import 'package:pab_kviz/pages/authenticate/sign_in.dart';
//import 'package:pab_kviz/pages/home/home.dart'; 
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
              Navigator.pushNamed(context, '/home');
            },
            child: Image.asset('assets/logo.png', height: 30),
          ),
          const SizedBox(width: 10),
          Text(title),
        ],
      ),
      actions: <Widget>[
        TextButton.icon(
          icon: const Icon(Icons.person),
          label: const Text('Logout'),
          onPressed: () async {
            await _auth.signOut();
            // Navigate to SignIn page
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
