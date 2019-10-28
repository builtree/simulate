import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:simulate/src/home.dart';
import 'package:provider/provider.dart';
import 'package:simulate/src/data/simulations.dart';

final _primaryColor = Colors.white;
final _counterColor = Colors.black;

final ThemeData _themeData = ThemeData(
  brightness: Brightness.light,
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

void main() => runApp(
      ChangeNotifierProvider<Simulations>(
        builder: (context) => Simulations(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Simulate',
            home: Home(),
            theme: _themeData),
      ),
    );
