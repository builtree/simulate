import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<Offset> ys = [];

class EpicycloidCurve extends StatefulWidget {
  @override
  _EpicycloidCurveState createState() => _EpicycloidCurveState();
}

class _EpicycloidCurveState extends State<EpicycloidCurve> {
  bool control = true;
  double time = 0;
  double amplitudeRadius = 50;
  double _k = 1;
  double f = 0.01;
  int delay = 0;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: 512.0,
      height: 1024.0,
      allowFontScaling: true,
    )..init(context);
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
          'Epicycloid Curve',
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Container(
              child: Transform.translate(
                offset: Offset(MediaQuery.of(context).size.width / 2,
                    (3 * MediaQuery.of(context).size.height) / 10),
                child: CustomPaint(
                  painter:
                      EpicycloidPainter(amplitudeRadius, time, _k, context),
                  child: Container(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: ScreenUtil.instance.height / 5,
        child: Container(
          child: Material(
            elevation: 30,
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Slider(
                  min: 1,
                  max: 10,
                  activeColor: Theme.of(context).accentColor,
                  inactiveColor: Colors.grey,
                  onChanged: (value) {
                    setState(() {
                      _k = value.toDouble();
                    });
                    ys.clear();
                  },
                  value: _k.toDouble(),
                ),
                Center(
                  child: Text(
                    "k: ${_k.toDouble()}",
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ),
                Slider(
                  min: 10,
                  max: 100,
                  activeColor: Theme.of(context).accentColor,
                  inactiveColor: Colors.grey,
                  onChanged: (value) {
                    setState(() {
                      amplitudeRadius = value.roundToDouble();
                    });
                    ys.clear();
                  },
                  value: amplitudeRadius,
                ),
                Center(
                  child: Text(
                    "Amplitude: ${amplitudeRadius.toInt()}",
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ),
                Slider(
                  min: 0,
                  max: 1,
                  activeColor: Theme.of(context).accentColor,
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
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EpicycloidPainter extends CustomPainter {
  double radius, time, r;
  Offset coor = new Offset(0, 0);
  Offset prevco;
  int n;
  double _k;
  BuildContext context;
  List<Offset> points = [];

  EpicycloidPainter(this.r, this.time, this._k, this.context) {
    radius = r / _k;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint.color = Theme.of(context).accentColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    paint.color = Colors.blue;
    canvas.drawCircle(coor, r.toDouble(), paint);
    for (int i = 0; i < 1; i++) {
      n = i + 1;
      prevco =
          Offset((r + radius) * cos(n * time), (r + radius) * sin(n * time));
      coor += Offset(
          ((radius * (_k + 1) * cos(n * time)) -
              (radius * cos((_k + 1) * n * time))),
          ((radius * (_k + 1) * sin(n * time)) -
              (radius * sin((_k + 1) * n * time))));
      paint.color = Theme.of(context).accentColor;
      canvas.drawLine(prevco, coor, paint);
      canvas.drawCircle(prevco, radius, paint);
      prevco =
          Offset((r + radius) * cos(n * time), (r + radius) * sin(n * time));
    }

    ys.insert(0, coor);
    paint.color = Colors.red;
    ys.forEach((value) {
      points.add(value);
    });

    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(EpicycloidPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(EpicycloidPainter oldDelegate) => false;
}
