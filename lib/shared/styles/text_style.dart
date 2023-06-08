import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTexts {

  // ********************************* English *********************************
  static TextStyle NovaSquare12BlackLight() =>
      GoogleFonts.novaSquare(
          fontSize: 12.sp, color: AppCloros.darkColor, fontWeight: FontWeight.normal);

  static TextStyle NovaSquare18WhiteLight() =>
      GoogleFonts.novaSquare(
          fontSize: 18.sp,
          color: AppCloros.darkColor,
          fontWeight: FontWeight.bold);

  static TextStyle NovaSquare24WhiteLight() =>
      GoogleFonts.novaSquare(
          fontSize: 24.sp,
          color: AppCloros.darkColor,
          fontWeight: FontWeight.bold);

  static TextStyle NovaSquare12WhiteDark() =>
      GoogleFonts.novaSquare(
          fontSize: 12.sp, color: AppCloros.lightColor, fontWeight: FontWeight.normal);

  static TextStyle NovaSquare18WhiteDark() =>
      GoogleFonts.novaSquare(
          fontSize: 18.sp,
          color: AppCloros.lightColor,
          fontWeight: FontWeight.bold);

  static TextStyle NovaSquare24WhiteDark() =>
      GoogleFonts.novaSquare(
          fontSize: 24.sp,
          color: AppCloros.lightColor,
          fontWeight: FontWeight.bold);


    // ********************************* Arabic *********************************
  static TextStyle Cairo12BlackLight() =>
      GoogleFonts.cairo(
          fontSize: 12.sp, color: AppCloros.darkColor, fontWeight: FontWeight.normal);

  static TextStyle Cairo18WhiteLight() =>
      GoogleFonts.cairo(
          fontSize: 18.sp,
          color: AppCloros.darkColor,
          fontWeight: FontWeight.bold);

  static TextStyle Cairo32WhiteLight() =>
      GoogleFonts.cairo(
          fontSize: 32.sp,
          color: AppCloros.darkColor,
          fontWeight: FontWeight.bold);

  static TextStyle Cairo12WhiteDark() =>
      GoogleFonts.cairo(
          fontSize: 12.sp, color: AppCloros.lightColor, fontWeight: FontWeight.normal);

  static TextStyle Cairo18WhiteDark() =>
      GoogleFonts.cairo(
          fontSize: 18.sp,
          color: AppCloros.lightColor,
          fontWeight: FontWeight.bold);

  static TextStyle Cairo22WhiteDark() =>
      GoogleFonts.cairo(
          fontSize: 22.sp,
          color: AppCloros.lightColor,
          fontWeight: FontWeight.bold);
}
