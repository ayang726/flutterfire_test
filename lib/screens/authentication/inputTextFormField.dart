import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextFormField extends StatelessWidget {
  final bool enable;
  final String labelText;
  final FocusNode focusNode;
  final bool obscureText;
  final Function onChange;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final Function onFieldSubmitted;
  final Function validator;
  InputTextFormField(
      {this.enable = false,
      this.labelText,
      this.focusNode,
      this.obscureText = false,
      this.onChange,
      this.textInputAction,
      this.keyboardType,
      this.onFieldSubmitted,
      this.validator});
  // Make email password and name field all reusable code here

  @override
  Widget build(BuildContext context) {
    if (enable) {
      return TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            filled: true,
            fillColor: Colors.white,
            labelText: labelText,
            labelStyle: TextStyle(fontSize: 20),
            errorStyle: TextStyle(fontSize: 15)),
        focusNode: focusNode,
        obscureText: obscureText,
        onChanged: onChange,
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        validator: validator,
      );
    } else {
      return Placeholder(fallbackHeight: 1);
    }
  }
}
