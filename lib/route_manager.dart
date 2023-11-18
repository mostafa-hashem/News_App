import 'package:flutter/material.dart';
import 'package:news_app/features/auth/ui/screens/login_screen.dart';
import 'package:news_app/features/auth/ui/screens/register_screen.dart';
import 'package:news_app/features/auth/ui/screens/reset_password_screen.dart';
import 'package:news_app/features/profile/ui/screens/profile_screen.dart';
import 'package:news_app/screens/full_new_screen.dart';
import 'package:news_app/screens/settings_tab.dart';
import 'package:news_app/ui/screens/home_layout.dart';
import 'package:news_app/ui/screens/splash_screen.dart';


class Routes {
  static const String layout = "/layout";
  static const String splash = "/splashScreen";
  static const String login = "/login";
  static const String resetPassword = "/resetPassword";
  static const String register = "/register";
  static const String home = "/home";
  static const String settings = "/settings";
  static const String fullNew = "/fullNew";
  static const String profile = "/profile";
}

Route? onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Routes.layout:
      return MaterialPageRoute(
        builder: (_) =>  const HomeLayout(),
      );
    case Routes.splash:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      );
    case Routes.login:
      return MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      );
    case Routes.resetPassword:
      return MaterialPageRoute(
        builder: (_) => const ResetPasswordScreen(),
      );
    case Routes.register:
      return MaterialPageRoute(
        builder: (_) => const RegisterScreen(),
      );
    case Routes.settings:
      return MaterialPageRoute(
        builder: (_) => const Settings(),
      );
    case Routes.fullNew:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const FullNew(),
      );
    case Routes.profile:
      return MaterialPageRoute(
        builder: (_) => const ProfileScreen(),
      );
    default:
      return null;
  }
}
