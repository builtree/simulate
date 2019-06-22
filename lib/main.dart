import 'package:flutter/material.dart';
import 'src/home.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simulate',
      home: StartScreen(),
    ));

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
