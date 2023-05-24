import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color backGroundColor = Color(0xffE5EFF1);
  static const Color mildGreen = Color(0xff107474);
  static const Color textColor = Color(0xff3A3A3D);
  static const Color lightRedColor = Color(0xffEBB3B4);
  static const Color whiteColor = Color.fromARGB(255, 255, 255, 255);

  static TextStyle appText({
    required double size,
    required FontWeight weight,
    FontStyle style = FontStyle.normal,
    Color color = whiteColor,
    bool isShadow = false,
  }) {
    return GoogleFonts.lato(
        fontSize: size,
        fontWeight: weight,
        fontStyle: style,
        color: color,
        shadows: isShadow
            ? [
                BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(0.1, 0.4),
                    spreadRadius: 3,
                    blurRadius: 2)
              ]
            : null);
  }

  static ButtonStyle buttonStyle(
      {double fontSize = 10,
      FontWeight weight = FontWeight.bold,
      double radius = 7,
      Color fontColor = Colors.white,
      required Color backColor,
      Color borderColor = Colors.transparent}) {
    return ElevatedButton.styleFrom(
        textStyle: appText(size: fontSize, weight: weight, color: fontColor),
        backgroundColor: backColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(color: borderColor)));
  }
}
