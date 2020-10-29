import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final TextAlign textAlign;
  const MyText(
      {Key key, @required this.text, this.color, this.fontSize, this.textAlign})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          color: color == null ? Colors.white : color,
          fontSize: fontSize == null ? 20 : fontSize),
      textAlign: textAlign == null ? TextAlign.start : textAlign,
    );
  }
}
