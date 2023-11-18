import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/ui/resources/app_colors.dart';
import 'package:news_app/ui/resources/text_styles.dart';

class MyThemeData {
  ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      iconTheme: const IconThemeData(
        size: 30,
        color: AppColors.darkColor,
      ),
      scaffoldBackgroundColor: AppColors.lightColor,
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 28,
        ),
        color: AppColors.greenColor,
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
        bodySmall: novaSquare12BlackLight(),
        bodyMedium: novaSquare18WhiteLight(),
        bodyLarge: novaSquare24WhiteLight(),
      ),
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      iconTheme: const IconThemeData(
        size: 30,
        color: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.darkColor,
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 28,
        ),
        color: AppColors.greenColor,
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
        bodySmall: novaSquare12WhiteDark(),
        bodyMedium: novaSquare18WhiteDark(),
        bodyLarge: novaSquare24WhiteDark(),
      ),
    );
  }
}
