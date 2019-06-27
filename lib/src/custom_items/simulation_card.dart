import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SimulationCard extends StatefulWidget {
  final String simulationName;
  final Widget direct;
  final String image;
  final String infoLink;
  SimulationCard(
      {Key key,
      @required this.simulationName,
      @required this.direct,
      @required this.image,
      @required this.infoLink})
      : super(key: key);

  _SimulationCardState createState() => _SimulationCardState();
}

class _SimulationCardState extends State<SimulationCard> {
  bool fav = false;
  _togglefav() {
    setState(() {
      fav = !fav;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 150,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget.direct),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                height: 130,
                width: 120,
                child: Image.asset(
                  widget.image,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                padding: EdgeInsets.all(3),
                child: Text(
                  widget.simulationName,
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                height: 30,
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
                      icon: (fav
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border)),
                      onPressed: () {
                        _togglefav();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
