import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'simulations/counting.dart';
import 'simulations/counter.dart';
import 'simulation_card.dart';
import 'category_card.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simulations'),
        backgroundColor: Colors.deepPurple[300],
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
    return ListView(
      primary: true,
      padding: EdgeInsets.all(5.0),
      // childAspectRatio: 18 / 19,
      // crossAxisSpacing: 10.0,
      // addRepaintBoundaries: true,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 4,
          
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              CategoryCard(
                  categoryName: 'General', image: 'images/counting2.jpg'),
              SimulationCard(
                direct: CountingTillN(),
                simulationName: 'ToothPick Pattern',
                image: 'images/counting.gif',
              ),
            ],
          ),
        ),
        // SimulationCard(
        //   direct: CountingTillN(),
        //   simulationName: 'Counting till N',
        //   image: 'images/counting.jpg'
        // ),
        // SimulationCard(
        //   simulationName: 'Counter',
        //   direct: CountingHome(),
        //   image: 'images/counting2.jpg',
      ],
    );
  }
}
