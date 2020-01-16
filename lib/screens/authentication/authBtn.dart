import 'package:flutter/material.dart';

class AuthBtn extends StatelessWidget {
  final Color btnColor;
  final Function onPressed;
  final String text;
  final Color textColor;

  const AuthBtn(
      {Key key,
      this.textColor = Colors.white,
      this.btnColor = const Color(0xFF0078A2),
      this.onPressed,
      this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40),
      textColor: textColor,
      color: btnColor,
      elevation: 0,
      child: Text(text,
          style: TextStyle(
            fontSize: 20,
          )),
      onPressed: onPressed,
    );
  }
}
