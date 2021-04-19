import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool obscureText;
  final String? initialValue;
  final String? Function(String?)? onSaved;
  final String? labelText;

  MyTextField(
      {this.controller,
      this.obscureText = false,
      this.initialValue,
      required this.labelText,
      this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      obscureText: obscureText,
      validator: (value) => value!.isEmpty ? 'The Format is not correct' : null,
      onSaved: onSaved,
      style: GoogleFonts.montserrat(color: Colors.white),
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white24,
          labelText: labelText,
          labelStyle: GoogleFonts.montserrat(color: Colors.white),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.deepPurple)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.white))),
    );
  }
}
