import 'package:flutter/material.dart';
import 'simulation_card.dart';
import '../simulations/toothpick.dart';
import '../simulations/langton_ant.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          HomeHorizontalList(
            listName: 'Recents',
            elements: <Widget>[
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
              )
            ],
          ),
        ],
      ),
    );
  }
}

class HomeHorizontalList extends StatelessWidget {
  final String listName;
  final List<Widget> elements;
  HomeHorizontalList(
      {Key key, @required this.listName, @required this.elements})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 235,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
            child: Text(
              listName,
              style: TextStyle(fontFamily: 'Ubuntu', fontSize: 17),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            color: Colors.white,
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: elements,
            ),
          ),
        ],
      ),
    );
  }
}
