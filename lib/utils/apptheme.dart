// theme for flutter
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConfig {
  static const Color greenLite = Color(0xFF5ab27e);
  static const Color pinkLite = Color(0xFFf9b8bb);
  static const Color viloteLite = Color(0xFFabafd5);
  static const Color viloteDark = Color(0xFF7279b9);
  static const Color yellow = Color(0xFFffee78);
  static const Color greenDark = Color(0xFF469767);
  static const Color redBg = Color(0xFFf0535b);
  static const Color pinkDark = Color(0xFFf7a0a4);
  static const Color greyBg = Color(0xFFeaeadf);
  static Color lightPrimary = Colors.white;
  static Color darkPrimary = const Color(0xff1f1f1f);
  static Color lightAccent = const Color(0xFFeaeadf);
  static Color darkAccent = const Color(0xff2ca8e2);
  static Color lightBG = Colors.white;
  static Color darkBG = const Color(0xff121212);

  // text theme
  static TextTheme textTheme = TextTheme(
    bodyText1: GoogleFonts.lato(
      textStyle: const TextStyle(
        color: Colors.black,
      ),
    ),
    bodyText2: GoogleFonts.lato(
      textStyle: const TextStyle(
        color: Colors.black,
      ),
    ),
    caption: GoogleFonts.lato(
      textStyle: const TextStyle(
        color: Colors.black,
      ),
    ),
    headline1: GoogleFonts.lato(
      textStyle: const TextStyle(
        color: Colors.black,
      ),
    ),
    headline2: GoogleFonts.lato(
      textStyle:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    headline3: GoogleFonts.lato(
      textStyle: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
    ),
    headline4: GoogleFonts.lato(
      textStyle: const TextStyle(
          color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
    ),
    headline5: GoogleFonts.lato(
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 25,
      ),
    ),
    headline6: GoogleFonts.lato(
      textStyle: const TextStyle(
        color: Colors.black,
      ),
    ),
    overline: GoogleFonts.lato(
      textStyle: const TextStyle(
        color: Colors.black,
      ),
    ),
    subtitle1: GoogleFonts.lato(
      textStyle: const TextStyle(color: Colors.black, fontSize: 20),
    ),
    subtitle2: GoogleFonts.lato(
      textStyle: const TextStyle(color: Colors.grey, fontSize: 16),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightBG,
    primaryTextTheme: textTheme,
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      color: Colors.transparent,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBG,
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
    ),
  );
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
