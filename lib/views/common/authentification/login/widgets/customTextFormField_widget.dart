import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final void Function()? datepicker;
  final TextEditingController? controller;
  final int? maxLine;
  final bool? prefixIcons;
  final FocusNode? focusNode;

  CustomTextFormField({
    required this.hintText,
    this.icon,
    this.keyboardType,
    required this.obscureText,
    required this.validator,
    this.onSaved,
    this.datepicker,
    this.controller,
    this.maxLine,
    this.prefixIcons,
    this.focusNode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        focusNode: focusNode ?? null,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLine,
        onSaved: onSaved,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          prefixIcon: prefixIcons == true
              ? Icon(
                  icon,
                  color: Colors.black54,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black54),
          errorStyle: TextStyle(
            color: Colors.red[300],
            overflow: TextOverflow.visible,
          ),
        ),
        onTap: datepicker,
      ),
    );
  }
}
