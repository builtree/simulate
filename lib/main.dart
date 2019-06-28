import 'package:flutter/material.dart';
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

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simulate'),
        backgroundColor: Colors.red[500],
      ),
      body: Center(
        child: RaisedButton(
          child: Text('START'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
        ),
      ),
    );
  }
}
