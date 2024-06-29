import 'package:pab_kviz/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:pab_kviz/shared/constants.dart';

class SignIn extends StatefulWidget {

  final Function? toggleView;
  const SignIn({super.key,required this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  String email = '';
  String password = '';

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 187, 178, 178),
        elevation: 0.0,
        title: Text('PRIJAVITE SE NA SAJT PAB KVIZA'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Napravi nalog'),
            onPressed: () {
            if (widget.toggleView != null) {
              widget.toggleView!();
              } else {
            // Handle the case where toggleView is null
          print('toggleView is null');
        }
      },
            
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                 validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                obscureText: true,
                onChanged: (val) {
                  
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                    WidgetStateProperty.all(Colors.pink[400]),
                    textStyle: WidgetStateProperty.all(
                    TextStyle(color: Colors.white))),
                child: Text(
                  'Prijavi se',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        error = 'Could not sign in with those credentials';
                      });
                    }
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}