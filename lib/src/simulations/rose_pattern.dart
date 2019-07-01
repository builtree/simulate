import 'dart:math';
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
    return ListView(
      padding: EdgeInsets.all(10),
      children: <Widget>[
        Center(
          child: Text(
            'Numerator: ${_n.round()}',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Slider(
          label: '${_n.round()}',
          min: 0,
          max: 100,
          divisions: 100,
          value: _n,
          onChanged: (double value) {
            setState(() {
              _n = value;
            });
          },
        ),
        Divider(),
        Center(
          child: Text(
            'Denominator: ${_d.round()}',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Slider(
          label: '${_d.round()}',
          min: 0,
          max: 100,
          divisions: 100,
          value: _d,
          onChanged: (double value) {
            setState(() {
              _d = value;
            });
          },
        ),
        Divider(),
        Container(
          width: MediaQuery.of(context).size.width,
          child: CustomPaint(
            painter: RosePainter(
                _d.round(),
                _n / _d,
                MediaQuery.of(context).size.width / 2,
                MediaQuery.of(context).size.height / 3),
            child: Container(),
          ),
        ),
        Divider(),
        Center(
          child: Text('Value of k (n/k): ${_n/_d}'),
        ),
      ],
    );
  }
}

class RosePainter extends CustomPainter {
  int d;
  double k, transformx, transformy;
  List<Offset> points = [];
  RosePainter(this.d, this.k, this.transformx, this.transformy);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.black;
    for (double i = 0; i < 2 * d * pi; i += 0.01) {
      points.add(Offset(200 * cos(k * i) * cos(i),
              200 * cos(k * i) * sin(i))
          .translate(transformx, transformy));
    }
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(RosePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(RosePainter oldDelegate) => false;
}
