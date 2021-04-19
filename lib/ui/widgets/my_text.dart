import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String? label;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  MyText(
      {required this.label,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.overflow});
  @override
  Widget build(BuildContext context) {
    return Text(
      label!,
      textAlign: textAlign,
      overflow: overflow,
      style: GoogleFonts.montserrat(
          fontSize: fontSize, color: color, fontWeight: fontWeight),
    );
  }
}
