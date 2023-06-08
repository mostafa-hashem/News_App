import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/widgets/language_bootom_sheet.dart';
import 'package:news_app/screens/widgets/theme_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../provider/app_provider.dart';
import '../shared/styles/app_colors.dart';
import '../shared/styles/text_style.dart';

class SettingsTab extends StatelessWidget {
  static const String routeName = "SettingsTab";

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyAppProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.settings,
            style: provider.language == "en"
                ? Theme.of(context).textTheme.bodyLarge
                : GoogleFonts.cairo(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(25.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: provider.language == "ar"
                    ? MediaQuery.of(context).size.height * 0.01
                    : MediaQuery.of(context).size.height * 0.03,
              ),
              Text(AppLocalizations.of(context)!.language,
                  style: provider.themeMode == ThemeMode.light
                      ? provider.language == "en"
                          ? AppTexts.NovaSquare12BlackLight()
                              .copyWith(fontSize: 16.sp)
                          : GoogleFonts.cairo()
                      : provider.language == "en"
                          ? AppTexts.NovaSquare12WhiteDark()
                              .copyWith(fontSize: 16.sp)
                          : GoogleFonts.cairo()),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              InkWell(
                onTap: () {
                  showLanguageSheet(context);
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01),
                  padding: provider.language == "ar"
                      ? EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.02)
                      : EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: AppCloros.greenColor,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      provider.language == 'en'
                          ? Text(
                              AppLocalizations.of(context)!.english,
                              style:
                                  GoogleFonts.novaSquare(color: Colors.black),
                            )
                          : Text(
                              AppLocalizations.of(context)!.arabic,
                              style: GoogleFonts.cairo(color: Colors.black),
                            ),
                      const Icon(Icons.arrow_drop_down,
                          size: 25, color: Colors.black)
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(AppLocalizations.of(context)!.theme,
                  style: provider.themeMode == ThemeMode.light
                      ? provider.language == "en"
                          ? AppTexts.NovaSquare12BlackLight()
                              .copyWith(fontSize: 16.sp)
                          : GoogleFonts.cairo()
                      : provider.language == "en"
                          ? AppTexts.NovaSquare12WhiteDark()
                              .copyWith(fontSize: 16.sp)
                          : GoogleFonts.cairo()),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              InkWell(
                onTap: () {
                  showThemeSheet(context);
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01),
                  padding: provider.language == "ar"
                      ? EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.02)
                      : EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: AppCloros.greenColor,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      provider.themeMode == ThemeMode.light
                          ? Text(AppLocalizations.of(context)!.lightMood,
                              style: provider.language == "en"
                                  ? GoogleFonts.novaSquare(color: Colors.black)
                                  : GoogleFonts.cairo(color: Colors.black))
                          : provider.themeMode == ThemeMode.system
                              ? Text(AppLocalizations.of(context)!.systemMood,
                                  style: provider.language == "en"
                                      ? GoogleFonts.novaSquare(
                                          color: Colors.black)
                                      : GoogleFonts.cairo(color: Colors.black))
                              : Text(AppLocalizations.of(context)!.darkMood,
                                  style: provider.language == "en"
                                      ? GoogleFonts.novaSquare(
                                          color: Colors.black)
                                      : GoogleFonts.cairo(color: Colors.black)),
                      const Icon(Icons.arrow_drop_down,
                          size: 25, color: Colors.black)
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              Center(
                child: Text.rich(TextSpan(children: [
                  provider.language == "en"
                      ? TextSpan(
                          text: "powered by ",
                          style: GoogleFonts.novaSquare(
                              color: provider.themeMode == ThemeMode.light
                                  ? Colors.black45
                                  : Colors.white70,
                              fontSize: 12.sp))
                      : TextSpan(
                          text: "مشغل بواسطة ",
                          style: GoogleFonts.cairo(
                              color: provider.themeMode == ThemeMode.light
                                  ? Colors.black45
                                  : Colors.white54,
                              fontSize: 12.sp)),
                  provider.language == "en"
                      ? TextSpan(
                          text: "MOSTAFA HASHEM",
                          style: GoogleFonts.novaSquare(fontSize: 15.sp))
                      : TextSpan(
                          text: "مصطفى هاشم",
                          style: GoogleFonts.cairo(fontSize: 15.sp))
                ])),
              )
            ],
          ),
        ));
  }

  void showLanguageSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return LanguageBottomSheet();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
    );
  }

  void showThemeSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ThemeBottomSheet();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0.r),
      ),
    );
  }
}
