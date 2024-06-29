import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pab_kviz/models/Korisnik.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;


  //create User based on firebase User
 Korisnik? _userFromFirebaseUser(User? user) {
  if (user == null) {
    return null;  // Return a default Korisnik object or handle null appropriately
  } else {
    return Korisnik(uid: user.uid);
  }
 }
  //auth change user stream
  Stream<Korisnik?> get user {
    return _auth.authStateChanges()
    .map((User? user)=>_userFromFirebaseUser(user));
  }

  //sign in anon
  Future signInAnon() async {
    try{

      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign in w/email and password

Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  //register w/email and password

 Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  //sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}