import 'package:flutter/material.dart';
import 'package:flutterfire_test/screens/authentication/authenticate.dart';
import 'package:flutterfire_test/services/firebaseAuth.dart';
import 'package:flutterfire_test/widgets/loading.dart';

class PasswordlessLogin extends StatefulWidget {
  final Function gotoAuthMethod;
  PasswordlessLogin({this.gotoAuthMethod});

  @override
  _PasswordlessLoginState createState() => _PasswordlessLoginState();
}

class _PasswordlessLoginState extends State<PasswordlessLogin> {
  var email = '';
  var password = '';
  var error = '';
  var loading = false;
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  AuthService _auth = AuthService();
  final _authFormKey = GlobalKey<FormState>();

/* These two methods are for passwordless signin functionalities, so far it doesn't work
because we don't have a app id for ios. and haven't set
 up for android*/
  void _handlePasswordlessLogin() {
    if (_authFormKey.currentState.validate()) {
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
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: Text('Passwordless Login'),
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
                        Text(
                          error,
                          style: TextStyle(color: Colors.red),
                        ),
                        RaisedButton(
                          child: Text('Submit'),
                          onPressed: _handlePasswordlessLogin,
                        ),
                      ],
                    ),
                  ),
                ),
                Text('Log in with email and password'),
                RaisedButton(
                  child: Text("Password Login"),
                  onPressed: () => widget
                      .gotoAuthMethod(LoginMethod.loginWithEmailAndPasssword),
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
