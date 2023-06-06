import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTexts {
  static TextStyle NovaSquare12BlackLight() =>
      GoogleFonts.novaSquare(
          fontSize: 12.sp, color: AppCloros.darkColor, fontWeight: FontWeight.normal);

  static TextStyle NovaSquare18WhiteLight() =>
      GoogleFonts.novaSquare(
          fontSize: 18.sp,
          color: AppCloros.darkColor,
          fontWeight: FontWeight.bold);

  static TextStyle NovaSquare32WhiteLight() =>
      GoogleFonts.novaSquare(
          fontSize: 32.sp,
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

  static TextStyle NovaSquare22WhiteDark() =>
      GoogleFonts.novaSquare(
          fontSize: 22.sp,
          color: AppCloros.lightColor,
          fontWeight: FontWeight.bold);
}
