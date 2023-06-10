import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/login_screen.dart';
import 'package:news_app/screens/widgets/theme_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../provider/app_provider.dart';

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
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 0.01.sh,
              ),
              Row(
                children: [
                  const Icon(Icons.dark_mode_outlined, size: 40),
                  SizedBox(
                    width: 0.03.sw,
                  ),
                  provider.themeMode == ThemeMode.light
                      ? GestureDetector(
                          onTap: () {
                            showThemeSheet(context);
                          },
                          child: const Icon(
                            Icons.toggle_off_outlined,
                            size: 45,
                          ))
                      : GestureDetector(
                          onTap: () {
                            showThemeSheet(context);
                          },
                          child: const Icon(
                            Icons.toggle_on_outlined,
                            size: 45,
                          ))
                ],
              ),
              SizedBox(
                height: 0.04.sh,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_circle_sharp,
                    size: 140,
                  ),
                ],
              ),
              SizedBox(height: 0.05.sh),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "User Name: ",
                    style: provider.themeMode == ThemeMode.light
                        ? GoogleFonts.novaSquare(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)
                        : GoogleFonts.novaSquare(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                TextSpan(
                    text: provider.myUser?.name,
                    style: provider.themeMode == ThemeMode.light
                        ? GoogleFonts.novaSquare(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)
                        : GoogleFonts.novaSquare(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold))
              ])),
              SizedBox(height: 0.03.sh),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Email: ",
                    style: provider.themeMode == ThemeMode.light
                        ? GoogleFonts.novaSquare(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)
                        : GoogleFonts.novaSquare(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                TextSpan(
                    text: provider.myUser?.email,
                    style: provider.themeMode == ThemeMode.light
                        ? GoogleFonts.novaSquare(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)
                        : GoogleFonts.novaSquare(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold))
              ])),
              SizedBox(height: 0.1.sh),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      provider.logout();
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routName);
                    },
                    child: Container(
                        width: 0.4.sw,
                        decoration:
                            const BoxDecoration(color: Color(0xff2C64C6)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "Log Out",
                            style: TextStyle(color: Colors.white),
                          )),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 0.2.sh),
              Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "powered by ",
                      style: GoogleFonts.novaSquare(
                          color: provider.themeMode == ThemeMode.light
                              ? Colors.black45
                              : Colors.white70,
                          fontSize: 12.sp)),
                  TextSpan(
                      text: "MOSTAFA HASHEM",
                      style: GoogleFonts.novaSquare(fontSize: 15.sp))
                ])),
              )
            ],
          ),
        ));
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
