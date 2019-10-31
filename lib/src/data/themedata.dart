import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _darkTheme;
  SharedPreferences prefs;
  Color _primaryColor = Colors.white;
  Color _counterColor = Colors.black;

  ThemeProvider(this.prefs) {
    _darkTheme = prefs.getBool('theme') ?? false;
    _primaryColor = _darkTheme ? Colors.black : Colors.white;
    _counterColor = _darkTheme ? Colors.white : Colors.black;
  }

  ThemeData get theme {
    return themeData();
  }

  ThemeData themeData() {
    return ThemeData(
      brightness: _darkTheme ? Brightness.dark : Brightness.light,
      accentColor: _counterColor,
      fontFamily: 'Ubuntu',
      indicatorColor: _counterColor,
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
