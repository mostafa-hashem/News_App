import 'package:flutter/material.dart';
import 'package:news_app/models/ctegory_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  String language = 'en';
  int selectedIndex = 0;
  CategoryModel? categoryModel = null;
  bool searchClicked = false;

  void changeLanguage(String newLanguage) async {
    if (language == newLanguage) {
      return;
    }
    language = newLanguage;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', newLanguage);
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) async {
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
                : 'light');
    notifyListeners();
  }

  void selectedItem(int value) {
    if (selectedIndex == value) {
      return;
    }
    selectedIndex = value;
    notifyListeners();
  }


  void onCategorySelected(category) {
    if (categoryModel == category) {
      return;
    }
    categoryModel = category;
    notifyListeners();
  }

  void onSearchClickedFalse() {
    searchClicked = true;
    notifyListeners();
  }

  void onSearchClickedTrue() {
    searchClicked = false;
    notifyListeners();
  }
}
