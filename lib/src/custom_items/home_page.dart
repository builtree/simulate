import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simulate/src/data/simulations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<Simulations>(context);
    return LayoutBuilder(
      // ignore: missing_return
      builder: (_, BoxConstraints constraints) {
        if (constraints.maxWidth != 0) {
          ScreenUtil.init(
            constraints,
            designSize: const Size(512.0, 850.0),
            allowFontScaling: false,
          );
          return ListView(
            children: <Widget>[
              HomeHorizontalList(
                listName: 'Favorites',
                elements: (appState.favorites.isNotEmpty)
                    ? appState.favorites
                    : [
                        SizedBox(
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
          );
        }
      },
    );
  }
}

class HomeHorizontalList extends StatelessWidget {
  final String listName;
  final List<Widget> elements;

  const HomeHorizontalList(
      {Key key, @required this.listName, @required this.elements})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
            child: Text(
              listName,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height >
                    MediaQuery.of(context).size.width
                ? ScreenUtil().setHeight(260)
                : 250,
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
