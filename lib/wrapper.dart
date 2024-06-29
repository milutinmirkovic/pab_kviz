import 'package:flutter/material.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'package:pab_kviz/pages/authenticate/authenticate.dart';
import 'package:pab_kviz/pages/home/home.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Korisnik?>(context);
    print(user);
    //ili home ili auth
    if(user == null){
      return Authenticate();
    }else{
      return Home(user: user);
    }
  }
}