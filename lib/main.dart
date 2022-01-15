import 'package:flutter/material.dart';
import 'package:simulate/src/home.dart';
import 'package:provider/provider.dart';
import 'package:simulate/src/data/simulations.dart';
import 'package:simulate/src/data/themedata.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Simulations>(
          lazy: false,
          create: (context) => Simulations(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          lazy: false,
          create: (context) => ThemeProvider(sharedPreferences),
        ),
      ],
      child: const HomeCall(),
    ),
  );
}

class HomeCall extends StatelessWidget {
  const HomeCall({Key key}) : super(key: key);

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
