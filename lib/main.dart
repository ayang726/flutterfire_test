import 'package:flutter/material.dart';
import 'package:flutterfire_test/screens/authWrapper.dart';
import 'package:flutterfire_test/services/firebaseAuth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: StreamProvider.value(
        value: AuthService().user,
        child: MaterialApp(
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
            primaryColor: const Color(0xFF0078A2),
            accentColor: Colors.white,
          ),
          home: AuthWrapper(),
        ),
      ),
    );
  }
}
