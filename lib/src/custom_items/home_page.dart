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
          HomeHorizontalListAnimate(
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
      margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
            child: Text(
              listName,
              style:
                  Theme.of(context).textTheme.subtitle.copyWith(fontSize: 17),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: 215,
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

class HomeHorizontalListAnimate extends StatelessWidget {
  final String listName;
  final List<Widget> elements;

  HomeHorizontalListAnimate(
      {Key key, @required this.listName, @required this.elements})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<Simulations>(context);
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
            child: Text(
              listName,
              style:
                  Theme.of(context).textTheme.subtitle.copyWith(fontSize: 17),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: 215,
            child: AnimatedList(   //Implementation of AnimtedList to toggle Favourites
                initialItemCount: elements.length,
                key: appState.listKey,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index, animation) {
                  return SlideTransition(
                    position: animation.drive(
                        Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                            .chain(CurveTween(curve: Curves.easeIn))),
                    child: elements[index],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
