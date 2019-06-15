import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simulate',
      home: MainMenu(),
    ));

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simulations'),
        backgroundColor: Colors.red[500],
      ),
      body: SimulationsList(),
    );
  }
}

class SimulationsList extends StatefulWidget {
  _SimulationsListState createState() => _SimulationsListState();
}

class _SimulationsListState extends State<SimulationsList> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      primary: true,
      padding: EdgeInsets.all(10.0),
      crossAxisSpacing: 10.0,
      children: <Widget>[
        Container(
          child: Material(
            color: Colors.cyanAccent[400],
            elevation: 14.0,
            borderRadius: BorderRadius.circular(20.0),
            shadowColor: Color(0x802196F3),
            child: Container(),
          ),
        ),
        Container(
          child: Material(
            color: Colors.amber[400],
            elevation: 14.0,
            borderRadius: BorderRadius.circular(20.0),
            shadowColor: Color(0x802196F3),
            child: Container(),
          ),
        ),
      ],
    );
  }
}
