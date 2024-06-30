class Korisnik{
  //final String uid;
  final String? email;
  //final String? password;
  final bool isAdmin;
  final String? token;

  Korisnik({required this.email,required this.isAdmin, required this.token});


  factory Korisnik.fromMap(Map<String, dynamic> data, String token) {
    return Korisnik(
      //uid: uid,
      email: data['email'],
      //password: data['password'],
      isAdmin: data['isAdmin'] ?? false,
      token: token,
    );
  }


}