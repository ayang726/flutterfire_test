import 'package:flutter/material.dart';
import 'package:flutterfire_test/services/firebaseAuth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Auth'),
        backgroundColor: Colors.green,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Log Out'),
            onPressed: _auth.logout,
          )
        ],
      ),
      body: Center(
        child: Text('Welcome to Vera, you have logged in'),
      ),
    );
  }
}
