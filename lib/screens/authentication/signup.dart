import 'package:flutter/material.dart';
import 'package:flutterfire_test/services/firebaseAuth.dart';

class SignUp extends StatefulWidget {
  final Function toggleSignup;
  SignUp({this.toggleSignup});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var email = '';
  var password = '';

  AuthService _auth = AuthService();

  void handleSignup() {
    _auth.signupWithEmailAndPassword(email, password).then((value) {
      print('user $value signed in');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.green,
        actions: <Widget>[
          FlatButton(
            child: Text('Log In'),
            onPressed: widget.toggleSignup,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              RaisedButton(
                child: Text('Submit'),
                onPressed: handleSignup,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
