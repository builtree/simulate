import 'package:flutter/material.dart';
import 'simulation_card.dart';
import '../simulations/toothpick.dart';
import '../simulations/langton_ant.dart';

class AlgorithmsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: (MediaQuery.of(context).size.width / 200).floor(),
        children: <Widget>[
          SimulationCard(
            simulationName: 'ToothPick Pattern',
            image: 'images/ToothpickPattern.gif',
            direct: ToothpickPattern()
          ),
          SimulationCard(
            simulationName: 'Langton\'s Ant',
            image: 'images/LangtonsAnt.gif',
            direct: LangtonAnt(),
          ),
        ],
      ),
    );
  }
}
