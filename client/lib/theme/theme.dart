import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  AppTheme._();
  static const Color backgroundWhite = Color(0xFFF7F8FC);
  static const Color black = Color(0xFF252733);
  // accesnt
  static const Color blue = Color(0xFF3751FF);
  // title
  static const Color grey1 = Color(0xFF9FA2B4);

  /// unselected text
  static const Color grey2 = Color(0xFFA4A6B3);
  static const Color menuBackground = Color(0xFF363740);

  /// selected text
  static const Color whitePink = Color(0xFFDDE2FF);

  static const Color whiteGrey = Color(0xFFFAFAFB);

  static const MaterialColor materialYellow = MaterialColor(
    0xFFDDE2FF,
    <int, Color>{
      50: Color(0xFFDDE2FF),
      100: Color(0xFFDDE2FF),
      200: Color(0xFFDDE2FF),
      300: Color(0xFFDDE2FF),
      400: Color(0xFFDDE2FF),
      500: Color(0xFFDDE2FF),
      600: Color(0xFFDDE2FF),
      700: Color(0xFFDDE2FF),
      800: Color(0xFFDDE2FF),
      900: Color(0xFFDDE2FF),
    },
  );
  static final ThemeData themeData = ThemeData(
    primarySwatch: materialYellow,
    primaryColor: materialYellow,

    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: blue,
    //  accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.black,
    inputDecorationTheme: inputDecorationTheme,
    scaffoldBackgroundColor: backgroundWhite,
    appBarTheme: AppBarTheme(
        elevation: 0,
        color: backgroundWhite,
        textTheme: AppTheme.textTheme.apply(bodyColor: black),
        iconTheme: const IconThemeData(
          color: blue,
        )),
    textTheme: AppTheme.textTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
  static final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    focusColor: Colors.black,
    labelStyle: const TextStyle(color: Colors.black),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0.r),
      borderSide: const BorderSide(color: Colors.black, width: 2),
    ),
    errorBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10.0.r),
      borderSide: const BorderSide(color: Colors.red, width: 4),
    ),
    enabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10.0.r),
      borderSide: BorderSide.none,
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10.0.r),
      borderSide: const BorderSide(color: Colors.red, width: 4),
    ),
  );
  static final TextTheme textTheme = TextTheme(
    headline1: GoogleFonts.montserrat(
        fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.montserrat(
        fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3:
        GoogleFonts.montserrat(fontSize: 48, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.montserrat(
        fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5:
        GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.montserrat(
        fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    subtitle1: GoogleFonts.montserrat(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: GoogleFonts.montserrat(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: GoogleFonts.roboto(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.roboto(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: GoogleFonts.roboto(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    caption: GoogleFonts.roboto(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: GoogleFonts.roboto(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  );
}
