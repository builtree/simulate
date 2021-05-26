import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:simulate/src/data/simulations.dart';

class SimulationCard extends StatefulWidget {
  final String simulationName;
  final Widget direct;
  final String image;
  final String infoLink;
  final int fav;
  final int id;
  SimulationCard(
      {Key key,
      @required this.id,
      @required this.simulationName,
      @required this.direct,
      @required this.image,
      @required this.infoLink,
      @required this.fav})
      : super(key: key);

  _SimulationCardState createState() => _SimulationCardState();
}

class _SimulationCardState extends State<SimulationCard> {
  int fav;

  @override
  void initState() {
    super.initState();
    fav = widget.fav;
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<Simulations>(context);
    return Container(
      width:
          MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
              ? ScreenUtil().setWidth(200)
              : 200,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => widget.direct),
          );
        },
        child: Card(
          elevation: 5,
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                flex: 10,
                child: Container(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.fromLTRB(3, 15, 3, 0),
                  child: Center(
                    child: FittedBox(
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.fitWidth,
                      child: Text(
                        widget.simulationName,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.info_outline),
                        onPressed: () async {
                          final url = widget.infoLink;
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch';
                          }
                        },
                      ),
                      IconButton(
                        icon: (widget.fav == 1)
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border),
                        onPressed: () {
                          setState(() {
                            appState.toggleFavorite(widget.id);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
