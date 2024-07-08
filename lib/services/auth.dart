import 'package:firebase_auth/firebase_auth.dart';
import 'package:pab_kviz/models/Korisnik.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String baseUrl = 'https://organizacija-pab-kvizova-default-rtdb.europe-west1.firebasedatabase.app';

  // Create Korisnik based on firebase User
  Korisnik? _userFromFirebaseUser(User? user, {String? token}) {
    if (user == null) {
      return null;  // Return a default Korisnik object or handle null appropriately
    } else {
      return Korisnik(email: user.email, isAdmin: false, token: token); //privremeno
    }
  }

  // Auth change user stream
  Stream<Korisnik?> get user {
    return _auth.authStateChanges().asyncMap((User? user) async {
      if (user != null) {
        // Fetch user data from Firebase Realtime Database
        try {
          final token = await user.getIdToken();
          //print(token);
          final response = await http.get(
            Uri.parse('$baseUrl/users/${user.uid}.json?auth=$token'),
          );

          if (response.statusCode == 200) {
            final responseData = json.decode(response.body);
            if (responseData == null) {
              print('User data not found');
              return null;
            }
            final userData = responseData as Map<String, dynamic>;
            return Korisnik.fromMap(userData, token!);
          } else {
            print('Failed to load user data: ${response.statusCode} ${response.body}');
            return null;
          }
        } catch (e) {
          print('Error fetching user data: $e');
          return null;
        }
      } else {
        return null;
      }
    });
  }

  // Sign in with email and password
  Future<Korisnik?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user != null) {
        final token = await user.getIdToken();
        final response = await http.get(
          Uri.parse('$baseUrl/users/${user.uid}.json?auth=$token'),
        );

        if (response.statusCode == 200) {
          print("sign in/response je vracen");
          final userData = json.decode(response.body) as Map<String, dynamic>;
          return Korisnik.fromMap(userData, token!);
        } else {
          print('Failed to load user data: ${response.statusCode} ${response.body}');
          return _userFromFirebaseUser(user);
        }
      }
      return null;
    } catch (e) {
      print('Error in signInWithEmailAndPassword: $e');
      return null;
    }
  }

  // Register with email and password
  Future<Korisnik?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user != null) {
        final token = await user.getIdToken();
        final response = await http.put(
          Uri.parse('$baseUrl/users/${user.uid}.json?auth=$token'),
          body: json.encode({
            'email': email,
            'password': password,
            'isAdmin': false,
          }),
        );

        if (response.statusCode == 200) {
          print("register/response je vracen");
          final userData = json.decode(response.body) as Map<String, dynamic>;
          return Korisnik.fromMap(userData, token!);
        } else {
          print('Failed to save user data: ${response.statusCode} ${response.body}');
          return _userFromFirebaseUser(user);
        }
      }
      return null;
    } catch (e) {
      print('Error in registerWithEmailAndPassword: $e');
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
