import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RosePattern extends StatefulWidget {
  @override
  _RosePatternState createState() => _RosePatternState();
}

class _RosePatternState extends State<RosePattern> {
  double _n = 0;
  double _d = 0;
  double k = 0;
  double offset = 0;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Rose Pattern',
          style: TextStyle(
            fontFamily: 'Ubuntu',
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height / 4,
        child: Material(
          elevation: 30,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Spacer(flex: 2),
              Slider(
                min: 0,
                max: 10,
                divisions: 1000,
                activeColor: Colors.black,
                inactiveColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    _n = double.parse(value.toStringAsFixed(2));
                  });
                },
                value: _n,
              ),
              Center(
                child: Text(
                  "Numerator: $_n",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Slider(
                min: 0,
                max: 10,
                divisions: 1000,
                activeColor: Colors.black,
                inactiveColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    _d = double.parse(value.toStringAsFixed(2));
                  });
                },
                value: _d,
              ),
              Center(
                child: Text(
                  "Denominator: $_d",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              Spacer(),
              Slider(
                min: 0,
                max: 1,
                divisions: 100,
                activeColor: Colors.black,
                inactiveColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    offset = double.parse(value.toStringAsFixed(2));
                  });
                },
                value: offset,
              ),
              Center(
                child: Text(
                  "Offset: $offset",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            CustomPaint(
              painter: RosePainter(
                _d,
                _n,
                (MediaQuery.of(context).size.width / 2).roundToDouble(),
                (MediaQuery.of(context).size.height / 3).roundToDouble(),
                (MediaQuery.of(context).size.width / 2.5).roundToDouble(),
                offset,
              ),
              child: Container(),
            ),
            Positioned(
              top: 5,
              left: 5,
              child: Text(
                'k ~ ${(_n /_d).toStringAsFixed(2)}',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RosePainter extends CustomPainter {
  double d, r, n, c;
  double k, transformx, transformy;
  List<Offset> points = [];
  RosePainter(
      this.d, this.n, this.transformx, this.transformy, this.r, this.c) {
    k = n / d;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    paint.strokeWidth = 2;
    for (double i = 0; i < 2 * d * pi; i += 0.01) {
      points.add(
          Offset(r * (cos(k * i) + c) * cos(i), r * (cos(k * i) + c) * sin(i))
              .translate(transformx, transformy));
    }
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(RosePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(RosePainter oldDelegate) => false;
}
