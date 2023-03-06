import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextStyle titleStyle = GoogleFonts.aBeeZee(
    fontWeight: FontWeight.bold,
    fontSize: 36,
  );

  static TextStyle mainStyle = GoogleFonts.aBeeZee(
    fontWeight: FontWeight.w700,
    fontSize: 24,
  );

  static TextStyle hintStyle = GoogleFonts.aBeeZee(
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );

  static TextStyle smallStyle = GoogleFonts.aBeeZee(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  static var darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.dark(
      primary: Colors.blueGrey.shade100,
      secondary: Colors.blueGrey.shade100,
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.black,
    ),
    iconTheme: const IconThemeData(
      color: Colors.blueGrey,
    ),
  );

  static var lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
  );
}
