import 'package:flutter/material.dart';

class SimulationCard extends StatefulWidget {
  final String simulationName;
  final Widget direct;
  final String image;
  SimulationCard(
      {Key key, @required this.simulationName, @required this.direct, @required this.image})
      : super(key: key);

  _SimulationCardState createState() => _SimulationCardState();
}

class _SimulationCardState extends State<SimulationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        semanticContainer: true,
        elevation: 10,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                      child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10.0)),
                    child: Image.asset(
                      widget.image,
                      fit: BoxFit.fill,
                    ),
                  )),
                  Positioned(
                    bottom: 10.0,
                    left: 10.0,
                    right: 16.0,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        widget.simulationName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => widget.direct,
                      ),
                    );
                  },
                  child: Text(
                    'START',
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                IconButton(
                  icon: Icon(Icons.star),
                  color: Colors.yellow,
                  onPressed: null,
                  iconSize: 30,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
