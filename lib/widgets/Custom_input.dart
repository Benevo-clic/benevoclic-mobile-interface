import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Function(String) onSaved;
  final String regEx;
  final String hintText;
  final bool obscureText;
  final String message;
  final Icon icon;

  CustomTextFormField(
      {required this.onSaved,
      required this.regEx,
      required this.hintText,
      required this.obscureText,
      required this.message,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (value) {
        print(value);
        onSaved(value!);
      },
      cursorColor: Colors.black54,
      style: TextStyle(color: Colors.black54),
      obscureText: obscureText,
      validator: (value) {
        return RegExp(regEx).hasMatch(value!) ? null : message;
      },
      decoration: InputDecoration(
        fillColor: Colors.white.withOpacity(0.5),
        filled: true,
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black54),
      ),
    );
  }
}
