import 'package:flutter/material.dart';
import 'simulations/counting.dart';
import 'simulations/counter.dart';
import 'simulations/langton_ant.dart';

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
      mainAxisSpacing: 10.0,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CountingTillN()),
            );
          },
          child: Container(
            child: Material(
              color: Colors.cyanAccent[400],
              elevation: 14.0,
              borderRadius: BorderRadius.circular(20.0),
              shadowColor: Color(0x802196F3),
              child: Container(
                  child: Center(
                child: Text('Counting Till N'),
              )),
            ),
          ),
        ),
        GestureDetector(
            child: Container(
              child: Material(
                color: Colors.amber[400],
                elevation: 14.0,
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Color(0x802196F3),
                child: Container(
                    child: Center(
                  child: Text('Counting'),
                )),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CountingHome()),
              );
            }),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LangtonAnt()),
            );
          },
          child: Container(
            child: Material(
              color: Colors.deepPurple,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(20.0),
              shadowColor: Color(0x802196F3),
              child: Container(
                  child: Center(
                child: Text(
                  "Langton's Ant",
                  style: TextStyle(color: Colors.white),
                ),
              )),
            ),
          ),
        ),
      ],
    );
  }
}
