import 'package:shared_preferences/shared_preferences.dart';

class Korisnik {
  final String? email;
  final bool isAdmin;
  final String? token;

  // Private constructor
  Korisnik._internal({required this.email, required this.isAdmin, required this.token});

  // Singleton instance
  static Korisnik? _instance;

  // Factory constructor
  factory Korisnik({required String? email, required bool isAdmin, required String? token}) {
    return _instance ??= Korisnik._internal(email: email, isAdmin: isAdmin, token: token);
  }

  // Method to set the current user
static Future<void> setCurrentUser(Map<String, dynamic> data, String token) async {
    _instance = Korisnik._internal(
      email: data['email'],
      isAdmin: data['isAdmin'] ?? false,
      token: token,
    );
    await saveToPreferences(_instance!);
  }

  
   static Future<void> clearCurrentUser() async {
    _instance = null;
    await clearPreferences();
  }

  // Method to get the current user
  static Korisnik? getCurrentUser() {
    return _instance;
  }

  factory Korisnik.fromMap(Map<String, dynamic> data, String token) {
    return Korisnik(
      email: data['email'],
      isAdmin: data['isAdmin'] ?? false,
      token: token,
    );
  }

  // Save user to SharedPreferences
  static Future<void> saveToPreferences(Korisnik user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', user.email ?? '');
    prefs.setBool('isAdmin', user.isAdmin);
    prefs.setString('token', user.token ?? '');
  }

  // Load user from SharedPreferences
  static Future<void> loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    bool isAdmin = prefs.getBool('isAdmin') ?? false;
    String? token = prefs.getString('token');

    if (email != null && token != null) {
      _instance = Korisnik._internal(email: email, isAdmin: isAdmin, token: token);
    }
  }

  // Clear user data from SharedPreferences
  static Future<void> clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('isAdmin');
    prefs.remove('token');
  }
}
