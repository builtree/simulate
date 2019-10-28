import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static var _darkTheme =false;
  var prefs;
  static var _primaryColor = Colors.white;
  static var _counterColor = Colors.black;

  ThemeProvider() {
    getThemeData();
  }

  ThemeData get theme {
    getThemeData();
    return themeData();
  }

  getThemeData() async {
    prefs = await SharedPreferences.getInstance();
    bool dark = await (prefs.getBool('theme') ?? false);
    _darkTheme = dark;
    _primaryColor = _darkTheme ? Colors.black : Colors.white;
    _counterColor = _darkTheme ? Colors.white : Colors.black;
  }

  ThemeData themeData() {
    return ThemeData(
      brightness: _darkTheme ? Brightness.dark : Brightness.light,
      accentColor: _counterColor,
      fontFamily: 'Ubuntu',
      indicatorColor: Colors.black,
      primaryColor: _primaryColor,
      textTheme: TextTheme(
        title: TextStyle(
          color: _counterColor,
          fontFamily: 'Ubuntu',
        ),
        subhead: TextStyle(
          color: _counterColor,
          fontFamily: 'Ubuntu',
        ),
        caption: TextStyle(
          color: Colors.grey[400],
          fontSize: 24,
          fontFamily: 'Ubuntu',
        ),
      ),
      appBarTheme: AppBarTheme(
        color: _primaryColor,
        iconTheme: IconThemeData(
          color: _counterColor,
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: _counterColor,
        unselectedLabelColor: _counterColor.withOpacity(0.3),
      ),
    );
  }

  bool get darkTheme {
    getThemeData();
    return _darkTheme;
  }

  void toggleTheme() async {
    _darkTheme = !_darkTheme;
    await prefs.setBool('theme', _darkTheme);
    _primaryColor = _darkTheme ? Colors.black : Colors.white;
    _counterColor = _darkTheme ? Colors.white : Colors.black;
    notifyListeners();
  }
}
