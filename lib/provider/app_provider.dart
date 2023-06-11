import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/NewsResponse.dart';
import 'package:news_app/models/ctegory_model.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/shared/network/firebase/firebase_functions.dart';
import 'package:news_app/shared/network/remot/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  String language = 'en';
  int selectedIndex = 0;
  CategoryModel? categoryModel = null;
  bool searchClicked = false;
  List<Articles> newsData = [];
  bool obscureTextLogin = true;
  bool obscureTextCreat = true;

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

  void onCategorySelectedNull() {
    if (categoryModel == null) {
      return;
    }
    categoryModel = null;
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

  void obscureTextCheckLogin() {
    obscureTextLogin = !obscureTextLogin;
    notifyListeners();
  }

  void obscureTextCheckCreat() {
    obscureTextCreat = !obscureTextCreat;
    notifyListeners();
  }

  Future<void> getNewsData(String sourceID, String query) async {
    try {
      NewsResponse newsResponse = await ApiManager.getNewsData(sourceID, query);
      newsData = newsResponse.articles!;
      notifyListeners();
    } catch (e) {}
  }

  UserModel? myUser;
  User? firebaseUser;

  MyAppProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
    notifyListeners();
  }

  void initUser() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    myUser = await FirebaseFunctions.readUser(firebaseUser!.uid);
  }

  void logout(){
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
