import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:simulate/src/home.dart';
import 'package:provider/provider.dart';
import 'package:simulate/src/data/simulations.dart';
import 'package:simulate/src/data/themedata.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Simulations>(
          builder: (context) => Simulations(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          builder: (context) => ThemeProvider(sharedPreferences),
        ),
      ],
      child: HomeCall(),
    ),
  );
}

class HomeCall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simulate',
      home: Home(),
      theme: theme.theme,
    );
  }
}
