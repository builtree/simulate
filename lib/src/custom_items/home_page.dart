import 'package:flutter/material.dart';
import 'simulation_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          HomeHorizontalList(
            listName: 'Favorites',
            elements: <Widget>[
              Container(
                width: 180,
              ),
              SimulationCard(
                simulationName: 'ToothPick Pattern',
                image: 'images/counting.gif',
                direct: null,
              ),
              SimulationCard(
                simulationName: 'ToothPick Pattern',
                image: 'images/counting.gif',
                direct: null,
              ),
              SimulationCard(
                simulationName: 'ToothPick Pattern',
                image: 'images/counting.gif',
                direct: null,
              ),
              SimulationCard(
                simulationName: 'ToothPick Pattern',
                image: 'images/counting.gif',
                direct: null,
              )
            ],
          ),
          HomeHorizontalList(
            listName: 'Recents',
            elements: <Widget>[
              Container(
                width: 180,
              ),
              SimulationCard(
                simulationName: 'ToothPick Pattern',
                image: 'images/counting.gif',
                direct: null,
              ),
              SimulationCard(
                simulationName: 'ToothPick Pattern',
                image: 'images/counting.gif',
                direct: null,
              ),
              SimulationCard(
                simulationName: 'ToothPick Pattern',
                image: 'images/counting.gif',
                direct: null,
              ),
              SimulationCard(
                simulationName: 'ToothPick Pattern',
                image: 'images/counting.gif',
                direct: null,
              )
            ],
          ),
          HomeHorizontalList(
            listName: 'Explore',
            elements: <Widget>[
              Container(
                width: 180,
              ),
              SimulationCard(
                simulationName: 'ToothPick Pattern',
                image: 'images/counting.gif',
                direct: null,
              ),
              SimulationCard(
                simulationName: 'ToothPick Pattern',
                image: 'images/counting.gif',
                direct: null,
              ),
              SimulationCard(
                simulationName: 'ToothPick Pattern',
                image: 'images/counting.gif',
                direct: null,
              ),
              SimulationCard(
                simulationName: 'ToothPick Pattern',
                image: 'images/counting.gif',
                direct: null,
              )
            ],
          ),
          HomeHorizontalList(
            listName: 'Suggested',
            elements: <Widget>[
              Container(
                width: 180,
              ),
              SimulationCard(
                simulationName: 'ToothPick Pattern',
                image: 'images/counting.gif',
                direct: null,
              ),
              SimulationCard(
                simulationName: 'ToothPick Pattern',
                image: 'images/counting.gif',
                direct: null,
              ),
              SimulationCard(
                simulationName: 'ToothPick Pattern',
                image: 'images/counting.gif',
                direct: null,
              ),
              SimulationCard(
                simulationName: 'ToothPick Pattern',
                image: 'images/counting.gif',
                direct: null,
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
