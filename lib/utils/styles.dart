import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.libreFranklin(
      fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.libreFranklin(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3:
      GoogleFonts.libreFranklin(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.libreFranklin(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.libreFranklin(
      fontSize: 23, fontWeight: FontWeight.w400, color: whiteColor),
  headline6: GoogleFonts.libreFranklin(
      fontSize: 19,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: whiteColor),
  subtitle1: GoogleFonts.libreFranklin(
      fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.15),
  subtitle2: GoogleFonts.libreFranklin(
      fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 0.1),
  bodyText1: GoogleFonts.libreFranklin(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Colors.grey[600]),
  bodyText2: GoogleFonts.libreFranklin(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.grey[600]),
  button: GoogleFonts.libreFranklin(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.libreFranklin(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.libreFranklin(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: colorSolitude),
      borderRadius: BorderRadius.circular(10),
      gapPadding: 10);

  OutlineInputBorder focusedOutlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: colorSecondary),
      borderRadius: BorderRadius.circular(10),
      gapPadding: 10);

  OutlineInputBorder disabledOutlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
      gapPadding: 10);

  return InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      filled: true,
      fillColor: colorSolitude,
      enabledBorder: outlineInputBorder,
      focusedBorder: focusedOutlineInputBorder,
      disabledBorder: disabledOutlineInputBorder,
      border: outlineInputBorder);
}
