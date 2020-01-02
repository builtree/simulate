import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LissajousCurve extends StatefulWidget {
  @override
  _LissajousCurveState createState() => _LissajousCurveState();
}

class _LissajousCurveState extends State<LissajousCurve> {
  double _a = 0;
  double _b = 0;
  double k = 0;
  double delta = 0;
  // int denominator = 0;

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
    ScreenUtil.instance = ScreenUtil(
      width: 512.0,
      height: 1024.0,
      allowFontScaling: true,
    )..init(context);
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
          'Lissajous Pattern',
          style: Theme.of(context).textTheme.title,
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        height: ScreenUtil.instance.height / 4,
        child: Material(
          elevation: 30,
          color: Theme.of(context).primaryColor,
          child: Column(
            children: <Widget>[
              Spacer(flex: 2),
              Slider(
                min: 0,
                max: 10,
                divisions: 1000,
                activeColor: Theme.of(context).accentColor,
                inactiveColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    _a = double.parse(value.toStringAsFixed(2));
                  });
                },
                value: _a,
              ),
              Center(
                child: Text(
                  "A: $_a",
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Slider(
                min: 0,
                max: 10,
                divisions: 1000,
                activeColor: Theme.of(context).accentColor,
                inactiveColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    _b = double.parse(value.toStringAsFixed(2));
                  });
                },
                value: _b,
              ),
              Center(
                child: Text(
                  "B: $_b",
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
              Spacer(),
              Slider(
                min: 0,
                max: 6.28,
                divisions: 100,
                activeColor: Theme.of(context).accentColor,
                inactiveColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    delta = double.parse(value.toStringAsFixed(2));
                    // denominator = delta~/0.628 != 0 ? 10~/(delta~/0.628) : 0;
                  });
                },
                value: delta,
              ),
              Center(
                child: Text(
                  "Delta: $delta",
                  style: Theme.of(context).textTheme.subtitle,
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
              painter: LissajousPainter(
                _b,
                _a,
                (MediaQuery.of(context).size.width / 2).roundToDouble(),
                (MediaQuery.of(context).size.height / 3).roundToDouble(),
                (MediaQuery.of(context).size.width / 2.5).roundToDouble(),
                delta,
              ),
              child: Container(),
            ),
            Positioned(
              top: 5,
              left: 5,
              child: Text(
                'A:B ~ ${(_a / _b).toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.subtitle,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LissajousPainter extends CustomPainter {
  double d, r, n, c;
  double k, transformx, transformy;
  List<Offset> points = [];
  LissajousPainter(
      this.d, this.n, this.transformx, this.transformy, this.r, this.c) {
    k = n / d;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    paint.strokeWidth = 2;
    // c = pi/4;
    for (double i = 0; i < 2 * pi; i += 0.01) {
      points.add(
          Offset(r * sin(n*i + c), r * sin(d * i))
              .translate(transformx, transformy));
    }
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(LissajousPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(LissajousPainter oldDelegate) => false;
}
