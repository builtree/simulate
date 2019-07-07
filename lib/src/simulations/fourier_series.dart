import 'dart:math';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<double> ys = [];

class FourierSeries extends StatefulWidget {
  @override
  _FourierSeriesState createState() => _FourierSeriesState();
}

class _FourierSeriesState extends State<FourierSeries> {
  bool control = true;
  double time = 0;
  double radius = 100;
  int _n = 1;
  double f = 0.01;
  String wave = 'Square Wave';
  int delay = 0;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    ys.clear();
    time = 0;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  update() {
    if (control == true) {
      setState(() {
        time -= f;
        if (ys.length == MediaQuery.of(context).size.width.toInt()) {
          ys.removeLast();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => update());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Fourier Series',
          style: TextStyle(
            fontFamily: 'Ubuntu',
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Row(
        children: <Widget>[
          Container(
            width: 2 * MediaQuery.of(context).size.width / 3,
            child: Transform.translate(
              offset:
                  Offset(radius, (4*MediaQuery.of(context).size.height) / 10),
              child: CustomPaint(
                painter: FourierPainter(radius, time, _n, wave),
                child: Container(),
              ),
            ),
          ),
          Expanded(
            child:Container(
              child: Material(
                elevation: 30,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    DropdownButton<String>(
                      value: wave,
                      iconSize: 30,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontFamily: 'Ubuntu',
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'Square Wave',
                          child: Text('Square Wave'),
                        ),
                        DropdownMenuItem(
                          value: 'SawTooth Wave',
                          child: Text('SawTooth Wave'),
                        ),
                      ],
                      onChanged: (value) {
                        wave = value;
                      },
                    ),
                    Slider(
                      min: 1,
                      max: 100,
                      activeColor: Colors.black,
                      inactiveColor: Colors.grey,
                      onChanged: (value) {
                        setState(() {
                          _n = value.toInt();
                        });
                      },
                      value: _n.toDouble(),
                    ),
                    Center(
                      child: Text(
                        "N: ${_n.toInt()}",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ),
                    Slider(
                      min: 10,
                      max: 200,
                      activeColor: Colors.black,
                      inactiveColor: Colors.grey,
                      onChanged: (value) {
                        setState(() {
                          radius = value.roundToDouble();
                        });
                      },
                      value: radius,
                    ),
                    Center(
                      child: Text(
                        "Amplitude: ${radius.toInt()}",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ),
                    Slider(
                      min: 0,
                      max: 1,
                      activeColor: Colors.black,
                      inactiveColor: Colors.grey,
                      onChanged: (value) {
                        setState(() {
                          f = value;
                        });
                      },
                      value: f,
                    ),
                    Center(
                      child: Text(
                        "- Frequency +",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FourierPainter extends CustomPainter {
  double radius;
  double time, r;
  Offset coor = new Offset(0, 0);
  Offset prevco;
  int n, _n;
  String wave;
  List<Offset> points = [];

  FourierPainter(this.r, this.time, this._n, this.wave);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    // canvas.translate(100, 200);
    for (int i = 0; i < _n; i++) {
      prevco = coor;
      if (wave == 'Square Wave') {
        n = i * 2 + 1;
        radius = r * (2 / (n * pi));
        coor += Offset((radius * cos(n * time)), (radius * sin(n * time)));
      }
      if (wave == 'SawTooth Wave') {
        n = i + 1;
        radius = r * (2 / (n * pi));
        coor += Offset((radius * cos(n * time)), (radius * sin(n * time)));
      }
      canvas.drawCircle(prevco, radius.toDouble(), paint);
      canvas.drawLine(prevco, coor, paint);
      prevco = coor;
    }

    ys.insert(0, coor.dy);
    paint.color = Colors.red;
    canvas.drawLine(coor, Offset(r, ys[0]), paint);
    int iterator = 0;
    paint.color = Colors.black;
    ys.forEach((value) {
      points.add(Offset(iterator.toDouble() + r, value));
      iterator++;
    });

    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(FourierPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(FourierPainter oldDelegate) => false;
}
