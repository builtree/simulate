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
            listName: 'Favorites',
            elements: (appState.favorites.length != 0)
                ? appState.favorites
                : [
                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      child: Center(
                        child: Text(
                          "No favorites yet!",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                  ],
          ),
          HomeHorizontalList(
            listName: 'All',
            elements: appState.all,
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
