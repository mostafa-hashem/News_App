import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/shared/styles/text_style.dart';
import 'app_colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    iconTheme: const IconThemeData(
      size: 30,
      color: AppCloros.darkColor,
    ),
    scaffoldBackgroundColor: AppCloros.lightColor,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 28,
      ),
      color: AppCloros.greenColor,
      centerTitle: true,
      toolbarHeight: 90,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(70.r),
          bottomRight: Radius.circular(70.r),
        ),
      ),
    ),
    textTheme: TextTheme(
      bodySmall: AppTexts.NovaSquare12BlackLight(),
      bodyMedium: AppTexts.NovaSquare18WhiteLight(),
      bodyLarge: AppTexts.NovaSquare24WhiteLight(),
    ),
  );
  static ThemeData darkTheme = ThemeData(

    brightness: Brightness.dark,
    iconTheme: const IconThemeData(
      size: 30,
      color: Colors.white,
    ),
    scaffoldBackgroundColor: AppCloros.darkColor,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 28,
      ),
      color: AppCloros.greenColor,
      centerTitle: true,
      toolbarHeight: 90,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(70.r),
          bottomRight: Radius.circular(70.r),
        ),
      ),
    ),
    textTheme: TextTheme(
      bodySmall: AppTexts.NovaSquare12WhiteDark(),
      bodyMedium: AppTexts.NovaSquare18WhiteDark(),
      bodyLarge: AppTexts.NovaSquare24WhiteDark(),
    ),
  );
}
