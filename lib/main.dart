import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfire_test/services/firebaseAuth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vera',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Firebase Auth'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userUid = '';
  String emailInput = '';
  String passwordInput = '';
  Authentication _auth = Authentication();

  void handleSignUp() {
    print('Sign up Pressed');
    _auth.signupWithEmailAndPassword(emailInput, passwordInput).then((value) {
      setState(() {
        userUid = value;
      });
    });
  }

  void handleLogIn() {
    print('Log In Pressed');
    _auth.loginWithEmailAndPassword(emailInput, passwordInput).then((value) {
      setState(() {
        userUid = value;
      });
    });
  }

  void handleSignInAnon() {
    _auth.signInAnonymous().then((value) {
      setState(() {
        userUid = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Vera, please log in or sign up',
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Email', hintText: 'Enter a valid email address'),
              onChanged: (text) {
                setState(() {
                  emailInput = text;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Password', hintText: 'Enter a password'),
              onChanged: (text) {
                setState(() {
                  passwordInput = text;
                });
              },
              obscureText: true,
            ),
            RaisedButton(
              child: Text('Sign Up'),
              onPressed: handleSignUp,
            ),
            RaisedButton(
              child: Text('Log In'),
              onPressed: handleLogIn,
            ),
            RaisedButton(
              child: Text('Anonymous'),
              onPressed: handleSignInAnon,
            ),
            Text(
              'User UID:',
            ),
            Text(userUid),
          ],
        ),
      ),
    );
  }
}
