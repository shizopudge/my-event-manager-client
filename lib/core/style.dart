import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextStyle mainStyle = GoogleFonts.raleway(
    fontWeight: FontWeight.w700,
    fontSize: 24,
  );

  static TextStyle hintStyle = GoogleFonts.raleway(
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );

  static TextStyle smallStyle = GoogleFonts.raleway(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  static var darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.dark(
      primary: Colors.blueGrey.shade100,
      secondary: Colors.blueGrey.shade100,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromARGB(255, 33, 36, 37),
    ),
    appBarTheme: const AppBarTheme(
      color: Color.fromARGB(255, 33, 36, 37),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    primaryIconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );

  static var lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
  );
}
