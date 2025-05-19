import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    textTheme:  GoogleFonts.manropeTextTheme(),
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.blue.shade900,
        onPrimary: Colors.white,
        secondary: Colors.black,
        onSecondary: Colors.white,
        error: Colors.red.shade800,
        onError: Colors.white,
        surface: Colors.black,
        onSurface: Colors.white
  ));
