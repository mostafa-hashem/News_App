import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/provider/app_provider.dart';
import 'package:news_app/screens/creat_account.dart';
import 'package:news_app/screens/full_new_screen.dart';
import 'package:news_app/screens/login_screen.dart';
import 'package:news_app/screens/settings_tab.dart';
import 'package:news_app/shared/styles/my_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'layout/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => MyAppProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  late MyAppProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MyAppProvider>(context);
    getPreferences();
    return ScreenUtilInit(
      designSize: const Size(412, 870),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: provider.firebaseUser != null
              ? HomeScreen.routeName
              : LoginScreen.routName,
          routes: {
            LoginScreen.routName: (c) => LoginScreen(),
            CreatAccount.routName: (c) => CreatAccount(),
            HomeScreen.routeName: (c) => HomeScreen(),
            SettingsTab.routeName: (c) => SettingsTab(),
            FullNewScreen.routeName: (c) => FullNewScreen(),
          },
          theme: MyThemeData.lightTheme,
          darkTheme: MyThemeData.darkTheme,
          themeMode: provider.themeMode,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(provider.language),
        );
      },
    );
  }

  void getPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('theme') == 'dark') {
      provider.changeTheme(ThemeMode.dark);
    } else if (prefs.getString('theme') == 'system') {
      provider.changeTheme(ThemeMode.system);
    } else {
      provider.changeTheme(ThemeMode.light);
    }
  }
}
