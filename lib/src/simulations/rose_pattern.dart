import 'dart:math' as prefix0;
import 'dart:ui';

import 'package:flutter/material.dart';

class RosePattern extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rose Pattern'),
        backgroundColor: Colors.pink,
      ),
      body: RosePatternSim(),
    );
  }
}

class RosePatternSim extends StatefulWidget {
  @override
  _RosePatternSimState createState() => _RosePatternSimState();
}

class _RosePatternSimState extends State<RosePatternSim> {
  double _n = 0;
  double _d = 0;
  double k = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('N'),
              Slider(
                label: '$_n',
                min: 0,
                max: 10,
                divisions: 10,
                value: _n,
                onChanged: (double value) {
                  setState(() {
                    _n = value;
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('D'),
              Slider(
                label: '$_d',
                min: 0,
                max: 10,
                divisions: 10,
                value: _d,
                onChanged: (double value) {
                  setState(() {
                    _d = value;
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          color: Colors.red,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          child: CustomPaint(
            painter: RosePainter(_d, _n/_d),
            child: Container(),
          ),
        )
      ],
    );
  }
}

class RosePainter extends CustomPainter {
  double d;
  double k;
  List<Offset> points = [];
  RosePainter(this.d, this.k);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white;
    for(double i = 0; i< 2*d*prefix0.pi; i+=0.01){
      points.add(Offset(100*prefix0.cos(k*i)*prefix0.cos(i),100*prefix0.cos(k*i)*prefix0.sin(i)).translate(150, 150));
    }
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(RosePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(RosePainter oldDelegate) => false;
}
