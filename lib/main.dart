import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:simulate/src/home.dart';
import 'package:provider/provider.dart';
import 'package:simulate/src/data/simulations.dart';

void main() => runApp(
      ChangeNotifierProvider<Simulations>(
        builder: (context) => Simulations(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Simulate',
          home: StartScreen(),
        ),
      ),
    );

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  timer() async => Timer(Duration(seconds: 2), homePage);

  homePage() => Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (builder) => Home(),
        ),
      );

  @override
  void initState() {
    super.initState();
    timer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset(
          'android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png',
          height: 600,
          width: 300,
        ),
      ),
    );
  }
}
