import 'package:flutter/material.dart';
import 'package:news_app/features/news/data/models/NewsResponse.dart';
import 'package:news_app/features/news/data/models/ctegory_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  String language = 'en';
  int selectedIndex = 0;
  CategoryModel? categoryModel;

  List<Articles> newsData = [];
  bool obscureTextLogin = true;
  bool obscureTextCreate = true;

  Future<void> changeLanguage(String newLanguage) async {
    if (language == newLanguage) {
      return;
    }
    language = newLanguage;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', newLanguage);
    notifyListeners();
  }

  Future<void> changeTheme(ThemeMode newTheme) async {
    if (themeMode == newTheme) {
      return;
    }
    themeMode = newTheme;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      'theme',
      newTheme == ThemeMode.dark
          ? 'dark'
          : newTheme == ThemeMode.system
              ? 'system'
              : 'light',
    );
    notifyListeners();
  }

  void selectedItem(int value) {
    if (selectedIndex == value) {
      return;
    }
    selectedIndex = value;
    notifyListeners();
  }

  void onCategorySelectedNull() {
    if (categoryModel == null) {
      return;
    }
    categoryModel = null;
    notifyListeners();
  }

  void onCategorySelected(CategoryModel category) {
    if (categoryModel == category) {
      return;
    }
    categoryModel = category;
    notifyListeners();
  }

  bool searchClicked = false;

  void onSearchClickedFalse() {
    searchClicked = true;
    notifyListeners();
  }

  void onSearchClickedTrue() {
    searchClicked = false;
    notifyListeners();
  }
  //
  // void obscureTextCheckLogin() {
  //   obscureTextLogin = !obscureTextLogin;
  //   notifyListeners();
  // }
  //
  // void obscureTextCheckCreat() {
  //   obscureTextCreate = !obscureTextCreate;
  //   notifyListeners();
  // }

  // UserModel? myUser;
  // User? firebaseUser;
  //
  // MyAppProvider() {
  //   firebaseUser = FirebaseAuth.instance.currentUser;
  //   if (firebaseUser != null) {
  //     initUser();
  //   }
  //   notifyListeners();
  // }

  // Future<void> initUser() async {
  //   firebaseUser = FirebaseAuth.instance.currentUser;
  //   myUser = await FirebaseFunctions.readUser(firebaseUser!.uid);
  // }

  // void logout() {
  //   FirebaseAuth.instance.signOut();
  //   notifyListeners();
  // }
}
