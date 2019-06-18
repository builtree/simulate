import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'simulations/counting.dart';
import 'simulations/counter.dart';
import 'simulation_card.dart';


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
      padding: EdgeInsets.all(5.0),
      childAspectRatio: 18 / 19,
      crossAxisSpacing: 10.0,
      addRepaintBoundaries: true,
      children: <Widget>[
        SimulationCard(
          direct: CountingTillN(),
          simulationName: 'Counting till N',
          image: 'images/counting.jpg'
        ),
        SimulationCard(
          simulationName: 'Counter',
          direct: CountingHome(),
          image: 'images/counting2.jpg',
        ),
      ],
    );
  }
}
