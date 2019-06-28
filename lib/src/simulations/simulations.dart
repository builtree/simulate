import 'package:flutter/material.dart';
import '../custom_items/simulation_card.dart';
import 'toothpick.dart';
import 'langton_ant.dart';

class Simulations {
  static final allSimulations = <Widget>[
    SimulationCard(
      simulationName: 'ToothPick Pattern',
      image: 'images/ToothpickPattern.gif',
      direct: ToothpickPattern(),
      infoLink: 'https://en.wikipedia.org/wiki/Toothpick_sequence',
    ),
    SimulationCard(
      simulationName: 'Langton\'s Ant',
      image: 'images/LangtonsAnt.gif',
      direct: LangtonAnt(),
      infoLink: 'https://en.wikipedia.org/wiki/Langton%27s_ant',
    ),
  ];

  static List<Widget> returnWidgets(List<int> a) {
    List<Widget> widgets = [];
    a.forEach((index) => widgets.add(allSimulations[index]));
    return widgets;
  }
}
