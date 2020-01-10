import 'package:flutter/material.dart';
import 'package:flutterfire_test/services/firebaseAuth.dart';

class LogIn extends StatefulWidget {
  final Function toggleSignup;
  LogIn({this.toggleSignup});

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  var email = '';
  var password = '';

  AuthService _auth = AuthService();

  void handleLogIn() {
    _auth.loginWithEmailAndPassword(email, password).then((value) {
      print('user $value signed in');
    }).catchError((e) {
      print('login error: $e.toString()');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
        actions: <Widget>[
          FlatButton(
            child: Text('Sign Up'),
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
                onPressed: handleLogIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
