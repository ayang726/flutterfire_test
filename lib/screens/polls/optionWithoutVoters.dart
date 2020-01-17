import 'package:flutter/material.dart';

typedef void OptionPressedCallback(String option);

class OptionWithoutVoters extends StatelessWidget {
  OptionWithoutVoters({
    this.option,
    this.onOptionPressed
  });

  final String option;
  final OptionPressedCallback onOptionPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: OutlineButton(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            option,
            style: TextStyle(fontSize: 18)
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        borderSide: BorderSide(color: Colors.blue),
        // TODO: onPressed
        onPressed: () => onOptionPressed(option)
      ),
      height: 90,
    );
  }
}