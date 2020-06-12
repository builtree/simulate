import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:simulate/src/data/simulations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<Simulations>(context);
    ScreenUtil.init(context);
    return Container(
      child: ListView(
        children: <Widget>[
          HomeHorizontalList(
            listName: 'Favorites',
            elements: (appState.favorites.length != 0)
                ? appState.favorites
                : [
                    Container(
                      width: ScreenUtil.screenWidthDp - 20,
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
    ScreenUtil.init(context);
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            width: ScreenUtil.screenWidth,
            child: Text(
              listName,
              style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 17),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(520),
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
