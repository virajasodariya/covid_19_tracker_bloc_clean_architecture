import 'package:covid_19_tracker_bloc_clean_architecture/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFontStyle {
  static TextStyle kDisplayMedium = GoogleFonts.playfairDisplay(
    color: MyColors.kCodGray,
    fontSize: 40.0,
    fontWeight: FontWeight.w600,
  );

  static TextStyle kDisplaySmall = GoogleFonts.poppins(
    color: MyColors.kCodGray,
    fontSize: 22.0,
    fontWeight: FontWeight.w600,
  );

  static TextStyle kHeadlineMedium = GoogleFonts.poppins(
    color: MyColors.kCodGray,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );
  static TextStyle kTitleLarge = GoogleFonts.poppins(
    color: MyColors.kRollingStone,
    fontSize: 16.0,
  );
  static TextStyle kBodySmall = GoogleFonts.poppins(
    color: MyColors.kCodGray,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
  );
}
