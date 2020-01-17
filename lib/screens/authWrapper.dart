import 'package:flutter/material.dart';
import 'package:flutterfire_test/models/user.dart';
import 'package:flutterfire_test/screens/authentication/authenticate.dart';
import 'package:flutterfire_test/screens/home/home.dart';
import 'package:flutterfire_test/screens/polls/poll.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Poll();
    }
  }
}
