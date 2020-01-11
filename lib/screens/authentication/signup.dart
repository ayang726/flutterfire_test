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
  var error = '';

  final AuthService _auth = AuthService();
  final _authFormKey = GlobalKey<FormState>();

  void _handleSignup() {
    _auth.signupWithEmailAndPassword(email, password).then((value) {
      print('user $value signed in');
    }).catchError((e) {
      setState(() {
        error = e.message;
      });
      print('signup error: $e.toString()');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        // backgroundColor: Colors.green,
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
          key: _authFormKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                validator: (value) =>
                    value.isEmpty ? "Email cannot be empty" : null,
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
                validator: (value) => value.length < 6
                    ? "Password must be 6 characters or more"
                    : null,
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red),
              ),
              RaisedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_authFormKey.currentState.validate()) {
                    _handleSignup();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
