import 'package:flutter/material.dart';
import 'package:pab_kviz/pages/authenticate/authenticate.dart';
import 'package:pab_kviz/pages/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //ili home ili auth
    return Authenticate();
  }
}