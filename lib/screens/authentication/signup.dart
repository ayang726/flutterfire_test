import 'package:flutter/material.dart';
import 'package:flutterfire_test/services/firebaseAuth.dart';
import 'package:flutterfire_test/widgets/spinner.dart';

import 'authBtn.dart';
import 'authenticate.dart';
import 'inputTextFormField.dart';

class Signup extends StatefulWidget {
  final Function navigateTo;
  Signup({this.navigateTo});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var name = "";
  var email = '';
  var password = '';
  var error = '';
  var loading = false;

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();

  AuthService _auth = AuthService();
  final _authFormKey = GlobalKey<FormState>();

  void _handleLogin() {
    widget.navigateTo(LoginMethod.loginWithEmailAndPasssword);
  }

  void _handleSignup() {
    if (_authFormKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      _auth.signupWithEmailAndPassword(name, email, password).then((value) {
        print('user $name signed in');
      }).catchError((e) {
        setState(() {
          loading = false;
          error = e.message;
        });
        print('signup error: $e.toString()');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingSpinner()
        : LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFF0078A2),
                            const Color(0xFF83E1B8)
                          ]),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight),
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
                              height: 330,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_nameFocusNode);
                                    },
                                    textInputAction: TextInputAction.next,
                                    validator: (value) => value.length < 6
                                        ? "Password must be longer than 6 characters"
                                        : null,
                                  ),
                                  InputTextFormField(
                                    enable: true,
                                    labelText: "Name",
                                    focusNode: _nameFocusNode,
                                    onChange: (value) {
                                      setState(() {
                                        name = value;
                                      });
                                    },
                                    onFieldSubmitted: (_) => {_handleSignup()},
                                    textInputAction: TextInputAction.done,
                                    validator: (value) => value.isEmpty
                                        ? "Name must not be empty"
                                        : null,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      AuthBtn(
                                        text: 'Sign Up',
                                        btnColor: Colors.white,
                                        textColor: const Color(0xFF0078A2),
                                        onPressed: _handleSignup,
                                      ),
                                      AuthBtn(
                                        text: 'Log In',
                                        btnColor: const Color(0xFF0078A2),
                                        textColor: Colors.white,
                                        onPressed: _handleLogin,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    error,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  Container()
                                ],
                              ),
                            ),
                          ),
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
