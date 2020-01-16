import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraint) {
      return Scaffold(
        body: Container(
          width: viewportConstraint.maxWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [const Color(0xFF0078A2), const Color(0xFF83E1B8)],
            ),
          ),
          child: Column(
            children: <Widget>[
              Spacer(flex: 2),
              Image(
                image: AssetImage('assets/images/veralogo.png'),
                fit: BoxFit.contain,
                width: viewportConstraint.maxWidth / 4 * 3,
              ),
              Text(
                'Vera',
                style: TextStyle(
                    fontSize: 150.0,
                    color: Colors.white,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.w400),
              ),
              Spacer(flex: 7),
            ],
          ),
        ),
      );
    });
  }
}
