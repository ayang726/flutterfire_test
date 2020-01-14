import 'package:flutter/material.dart';
import 'package:flutterfire_test/services/firebaseAuth.dart';
import 'package:flutterfire_test/widgets/spinner.dart';

class LogIn extends StatefulWidget {
  final Function toggleSignup;
  LogIn({this.toggleSignup});

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  var email = '';
  var password = '';
  var error = '';
  var loading = false;
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  AuthService _auth = AuthService();
  final _authFormKey = GlobalKey<FormState>();

  void _handleLogIn() {
    if (_authFormKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      _auth.loginWithEmailAndPassword(email, password).then((value) {
        print('message-900 user ${value.name} signed in');
      }).catchError((e) {
        setState(() {
          loading = false;
          error = e.message;
        });
        print('login error: $e.toString()');
      });
    }
  }

/* These two methods are for passwordless signin functionalities, so far it doesn't work
because we don't have a app id for ios. and haven't set up for android*/
  void _handlePasswordlessLogin() {
    setState(() {
      loading = true;
    });
    _auth.loginWithEmailAndLink(email).then(print).catchError((e) {
      setState(() {
        loading = false;
        error = e.message;
      });
      print('login error: $e.toString()');
    });
  }

  void _handleSigninAnon() {
    setState(() {
      loading = true;
    });
    _auth.signInAnonymous().then(print).catchError((e) {
      setState(() {
        loading = false;
        error = e.message;
      });
      print('login error: $e.toString()');
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _auth.retrieveDynamicLink(email: email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingSpinner()
        : Scaffold(
            appBar: AppBar(
              title: Text('Log In'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Sign Up'),
                  onPressed: widget.toggleSignup,
                ),
              ],
            ),
            body: Column(
              children: <Widget>[
                Container(
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
                          focusNode: _emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },
                          textInputAction: TextInputAction.next,
                          validator: (value) =>
                              value.isEmpty ? "Email cannot be empty" : null,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                          focusNode: _passwordFocusNode,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          onFieldSubmitted: (_) => {_handleLogIn()},
                          textInputAction: TextInputAction.send,
                          validator: (value) => value.isEmpty
                              ? "Password must not be empty"
                              : null,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red),
                        ),
                        RaisedButton(
                          child: Text('Submit'),
                          onPressed: _handleLogIn,
                        ),
                      ],
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text("Sign in With Link"),
                  onPressed: _handlePasswordlessLogin,
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.link_off),
              tooltip: 'Sign in Anonymously',
              onPressed: _handleSigninAnon,
            ),
          );
  }
}
