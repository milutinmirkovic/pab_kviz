class Korisnik{

  final String? email;
  
  final bool isAdmin;
  final String? token;

  Korisnik({required this.email,required this.isAdmin, required this.token});


  factory Korisnik.fromMap(Map<String, dynamic> data, String token) {
    return Korisnik(
      
      email: data['email'],
      isAdmin: data['isAdmin'] ?? false,
      token: token,
    );
  }


}