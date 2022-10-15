import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/utils/theme/outlinedButtonTheme.dart';
import 'package:movie_login/src/utils/theme/textfieldTheme.dart';

class TAppTheme {
//para deixar privado e o usuario nao poder alterar
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TextTheme(
      headline2: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
      headline1: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 14,
      ),
      bodyText2: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headline3: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      headline4: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      headline5: GoogleFonts.roboto(
        color: tThirdColor,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    ),
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,  
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(
      headline2: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
      headline1: GoogleFonts.montserrat(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 14,
      ),
      bodyText2: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headline3: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      headline4: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      headline5: GoogleFonts.roboto(
        color: tThirdColor,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    ),

    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}
