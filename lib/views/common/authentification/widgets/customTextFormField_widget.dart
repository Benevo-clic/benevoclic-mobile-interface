import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?) validator;
  final void Function(String?) onSaved;

  CustomTextFormField({
    required this.hintText,
    required this.icon,
    required this.keyboardType,
    required this.obscureText,
    required this.validator,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        onSaved: onSaved,
        validator: validator,
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          prefixIcon: Icon(
            icon,
            color: Colors.black54,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black54),
          errorStyle: TextStyle(
            color: Colors.blue,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }
}
