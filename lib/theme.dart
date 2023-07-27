import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.openSansTextTheme(),
  primaryColorDark: const Color(0xFF0097A7),
  primaryColorLight: const Color(0xFFB2EBF2),
  primaryColor: const Color(0xFF00BCD4),
  /* colorScheme => define main color theme of the app */
  colorScheme: const ColorScheme.light(primary: Colors.indigo,
      secondary: Color(0xFF009688)),
  scaffoldBackgroundColor: const Color(0xFFE0F2F1),
  iconTheme: const IconThemeData(color: Color(0xFFE0F2F1)),
  highlightColor: Colors.indigoAccent,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.indigoAccent,
    foregroundColor: Color(0xFFE0F2F1)
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.indigoAccent,
      foregroundColor: Colors.white
    )
  ),

  listTileTheme: const ListTileThemeData(
    selectedTileColor: Colors.indigoAccent
  )
);