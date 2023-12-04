import 'package:covid_19_tracker_bloc_clean_architecture/Utils/colors.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData covidTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.black,
  scaffoldBackgroundColor: MyColors.kPorcelain,
  appBarTheme: _appBarTheme(),
  textTheme: _textTheme(),
  colorScheme: _colorScheme(),
);

AppBarTheme _appBarTheme() {
  return AppBarTheme(
    elevation: 0.0,
    shadowColor: Colors.transparent,
    titleTextStyle: GoogleFonts.playfairDisplay(
      color: MyColors.kCodGray,
      fontSize: 40.0,
      fontWeight: FontWeight.w500,
    ),
  );
}

TextTheme _textTheme() {
  return TextTheme(
    displayMedium: MyFontStyle.kDisplayMedium,
    displaySmall: MyFontStyle.kDisplaySmall,
    headlineMedium: MyFontStyle.kHeadlineMedium,
    titleLarge: MyFontStyle.kTitleLarge,
    bodySmall: MyFontStyle.kBodySmall,
  );
}

ColorScheme _colorScheme() {
  return const ColorScheme.light(
    primary: MyColors.kPorcelain,
    onPrimary: MyColors.kCodGray,
    onError: Colors.redAccent,
    background: MyColors.kPorcelain,
  );
}
