import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simulate/src/data/simulations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.height);
    ScreenUtil.init(context, width: 512, height: 1005, allowFontScaling: false);
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
      margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
            child: Text(
              listName,
              style: Theme.of(context).textTheme.subtitle1,//.copyWith(fontSize: 17),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(220),
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
