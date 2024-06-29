class Korisnik{
  final String uid;
  final String? email;
  final String? password;
  final bool isAdmin;

  Korisnik({required this.uid, required this.email,required this.password, required this.isAdmin});


  factory Korisnik.fromMap(Map<String, dynamic> data, String uid) {
    return Korisnik(
      uid: uid,
      email: data['email'],
      password: data['password'],
      isAdmin: data['isAdmin'] ?? false,
    );
  }

}