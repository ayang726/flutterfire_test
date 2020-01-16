import 'package:flutter/material.dart';
import 'package:flutterfire_test/screens/authentication/authBtn.dart';
import 'package:flutterfire_test/screens/authentication/authenticate.dart';
import 'package:flutterfire_test/screens/authentication/inputTextFormField.dart';
import 'package:flutterfire_test/services/firebaseAuth.dart';

class Login extends StatefulWidget {
  final Function navigateTo;
  Login({this.navigateTo});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = '';
  var password = '';
  var error = '';
  var loading = false;

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  AuthService _auth = AuthService();
  final _authFormKey = GlobalKey<FormState>();

  void _handleSignup() {
    widget.navigateTo(LoginMethod.signupWithEmailAndPassword);
  }

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
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [const Color(0xFF0078A2), const Color(0xFF83E1B8)]),
              ),
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: Column(
                  children: [
                    Padding(
                      child: Image(
                        image: AssetImage("assets/images/veralogo.png"),
                        fit: BoxFit.contain,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100.0, vertical: 40.0),
                    ),
                    Form(
                      key: _authFormKey,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        height: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InputTextFormField(
                              enable: true,
                              labelText: 'Email',
                              focusNode: _emailFocusNode,
                              onChange: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode);
                              },
                              textInputAction: TextInputAction.next,
                              validator: (value) => value.isEmpty
                                  ? "Email cannot be empty"
                                  : null,
                            ),
                            InputTextFormField(
                              enable: true,
                              labelText: 'Password',
                              focusNode: _passwordFocusNode,
                              obscureText: true,
                              onChange: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                              onFieldSubmitted: (_) => {_handleLogIn()},
                              textInputAction: TextInputAction.done,
                              validator: (value) => value.isEmpty
                                  ? "Password must not be empty"
                                  : null,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                AuthBtn(
                                  text: 'Sign Up',
                                  btnColor: const Color(0xFF0078A2),
                                  textColor: Colors.white,
                                  onPressed: _handleSignup,
                                ),
                                AuthBtn(
                                  text: 'Log In',
                                  btnColor: Colors.white,
                                  textColor: const Color(0xFF0078A2),
                                  onPressed: _handleLogIn,
                                ),
                              ],
                            ),
                            Text(
                              error,
                              style: TextStyle(color: Colors.red),
                            ),
                            FlatButton(
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => widget
                                    .navigateTo(LoginMethod.resetPassword)),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image(
                            image: AssetImage('assets/images/fblogo.png'),
                            fit: BoxFit.contain,
                            width: 70,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image(
                            image: AssetImage('assets/images/googlelogo.png'),
                            fit: BoxFit.contain,
                            width: 70,
                          ),
                        ),
                      ],
                    ),
                    FlatButton(
                      child: Text(
                        'Continue as Guest',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: _handleSigninAnon,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
