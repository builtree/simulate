import 'package:flutter/material.dart';
import 'package:simulate/src/data/simulations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<Simulations>(context);
    return Container(
      child: ListView(
        children: <Widget>[
          HomeHorizontalList(
            listName: 'Recents',
            elements: appState.allSimulations()
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
