import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Mytheme {
  static ThemeData get theme => ThemeData(
      // primarySwatch: Colors.cyan,
      fontFamily: GoogleFonts.lato().fontFamily,
      appBarTheme: AppBarTheme(color: Colors.purple, centerTitle: true));
}
