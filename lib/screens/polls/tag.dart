import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  Tag({this.tag});

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: OutlineButton(
        child: Text(tag),
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(horizontal: 10),
        borderSide: BorderSide(color: Colors.blue),
        // TODO: onPressed
        onPressed: () => print('$tag button pressed')
      )
    );
  }
}