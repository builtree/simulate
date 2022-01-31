import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        if (ys.length == ScreenUtil().uiSize.width.toInt()) {
          ys.removeLast();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => update());
    return LayoutBuilder(
      // ignore: missing_return
      builder: (_, BoxConstraints constraints) {
        if (constraints.maxWidth != 0) {
          ScreenUtil.init(
            constraints,
            context: context,
            designSize: Size(1024.0, 512.0),
            minTextAdapt: true,
          );
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
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            body: Row(
              children: <Widget>[
                Container(
                  width: 2 * ScreenUtil().setWidth(1024 / 3),
                  child: Transform.translate(
                    offset: Offset(
                        radius, (4 * MediaQuery.of(context).size.height) / 10),
                    child: CustomPaint(
                      painter: FourierPainter(radius, time, _n, wave, context),
                      child: Container(),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Material(
                      elevation: 30,
                      color: Theme.of(context).primaryColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          DropdownButton<String>(
                            value: wave,
                            iconSize: 30,
                            style: Theme.of(context).textTheme.subtitle2,
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
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
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
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                          Slider(
                            min: 10,
                            max: 200,
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
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
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                          Slider(
                            min: 0,
                            max: 0.3,
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
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
                              style: Theme.of(context).textTheme.subtitle2,
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
      },
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
  BuildContext context;
  List<Offset> points = [];

  FourierPainter(this.r, this.time, this._n, this.wave, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint.color = Theme.of(context).colorScheme.secondary;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
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
    paint.color = Theme.of(context).colorScheme.secondary;
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
