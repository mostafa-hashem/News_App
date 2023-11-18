import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/auth/cubit/auth_cubit.dart';
import 'package:news_app/features/news/cubit/cubit.dart';
import 'package:news_app/features/profile/cubit/profile_cubit.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/provider/app_provider.dart';
import 'package:news_app/route_manager.dart';
import 'package:news_app/ui/resources/my_theme.dart';
import 'package:news_app/utils/bloc_observer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = AppBlocObserver();
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => MyAppProvider(), child: MyApp(),),);
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyAppProvider provider;
  final MyThemeData _themeData = MyThemeData();

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MyAppProvider>(context);
    getPreferences();
    return ScreenUtilInit(
      designSize: const Size(412, 870),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AuthCubit()..getAuthStatus(),
            ),
            BlocProvider(
              create: (_) => NewsCubit(),
            ),
            BlocProvider(
              create: (_) => ProfileCubit(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.layout,
            onGenerateRoute: onGenerateRoute,
            theme: _themeData.lightTheme(),
            darkTheme: _themeData.darkTheme(),
            themeMode: provider.themeMode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(provider.language),
          ),
        );
      },
    );
  }

  Future<void> getPreferences() async {
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
