import 'package:flutter/material.dart';

class SimulationCard extends StatefulWidget {
  final String simulationName;
  final Widget direct;
  final String image;
  bool fav = false;
  SimulationCard(
      {Key key,
      @required this.simulationName,
      @required this.direct,
      @required this.image})
      : super(key: key);

  _SimulationCardState createState() => _SimulationCardState();
}

class _SimulationCardState extends State<SimulationCard> {
  _togglefav() {
    print(1);
    setState(() {
      widget.fav = !widget.fav;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10,
        child: Column(
          children: <Widget>[
            Container(
              width: 160,
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    width: 150,
                    height: MediaQuery.of(context).size.height / 4 - 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        widget.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      child: Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      onTap: _togglefav(),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(widget.simulationName, style: TextStyle(fontWeight: FontWeight.w700),),
            )
          ],
        ),
      ),
    );
  }
}
