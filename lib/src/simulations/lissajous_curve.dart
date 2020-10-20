import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

GlobalKey<_LissajousState> globalKey = GlobalKey<_LissajousState>();

class LissajousCurve extends StatefulWidget {
  @override
  _LissajousCurveState createState() => _LissajousCurveState();
}

class _LissajousCurveState extends State<LissajousCurve> {
  double _a = 0;
  double _b = 0;
  double k = 0;
  double delta = 0;
  bool animate = false;
  bool animating = false;
  double thickness = 2;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 512.0,
      height: 1024.0,
      allowFontScaling: true,
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
        title: Text(
          'Lissajous Pattern',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible: animate,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.white,
                  child: (!animating)
                      ? Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                        )
                      : Icon(
                          Icons.pause,
                          color: Colors.black,
                        ),
                  onPressed: () {
                    setState(() {
                      animating = !animating;
                    });
                  }),
              FloatingActionButton(
                heroTag: null,
                child: Icon(
                  Icons.highlight_off,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                onPressed: () {
                  setState(() {
                    globalKey.currentState.clearscreen();
                  });
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: !isLandscape(),
        child: parameters(
          context,
          ScreenUtil().setHeight(1024 / 5),
        ),
      ),
      body: Row(
        children: [
          Container(
            width: isLandscape()
                ? 2 * MediaQuery.of(context).size.width / 3
                : MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Lissajous(
                  b: _b,
                  a: _a,
                  delta: delta,
                  animate: animate,
                  animating: animating,
                  key: globalKey,
                  thickness: thickness,
                  isLandscape: isLandscape(),
                ),
                Positioned(
                  top: 5,
                  left: 5,
                  child: Text(
                    'A:B ~ ${(_a / _b).toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('Animate: '),
                      Checkbox(
                        onChanged: (_) {
                          setState(() {
                            animate = !animate;
                            if (animating) {
                              animating = (animating && animate);
                            }
                          });
                        },
                        value: animate,
                        activeColor: Colors.red,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: isLandscape(),
            child: Expanded(
              child: parameters(
                context,
                MediaQuery.of(context).size.height,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isLandscape() {
    return MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height;
  }

  Container parameters(BuildContext context, num height) {
    return Container(
      height: height,
      child: Material(
        elevation: 30,
        color: Theme.of(context).primaryColor,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Slider(
              min: 0,
              max: 10,
              divisions: 100,
              activeColor: Theme.of(context).accentColor,
              inactiveColor: Colors.grey,
              onChanged: (value) {
                setState(() {
                  _a = double.parse(value.toStringAsFixed(1));
                });
              },
              value: _a,
            ),
            Center(
              child: Text(
                "A: $_a",
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            Slider(
              min: 0,
              max: 10,
              divisions: 100,
              activeColor: Theme.of(context).accentColor,
              inactiveColor: Colors.grey,
              onChanged: (value) {
                setState(() {
                  _b = double.parse(value.toStringAsFixed(1));
                });
              },
              value: _b,
            ),
            Center(
              child: Text(
                "B: $_b",
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            Slider(
              min: 0,
              max: 6.28,
              divisions: 100,
              activeColor: Theme.of(context).accentColor,
              inactiveColor: Colors.grey,
              onChanged: (value) {
                setState(() {
                  delta = double.parse(value.toStringAsFixed(2));
                });
              },
              value: delta,
            ),
            Center(
              child: Text(
                "Delta: $delta",
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            Slider(
              min: 2,
              max: 6,
              divisions: 100,
              activeColor: Theme.of(context).accentColor,
              inactiveColor: Colors.grey,
              onChanged: (value) {
                setState(() {
                  thickness = double.parse(value.toStringAsFixed(2));
                });
              },
              value: thickness,
            ),
            Center(
              child: Text("Thickness: $thickness",
                  style: Theme.of(context).textTheme.subtitle2),
            ),
          ],
        ),
      ),
    );
  }
}

class Lissajous extends StatefulWidget {
  Lissajous({
    Key key,
    @required double b,
    @required double a,
    @required this.delta,
    @required this.animate,
    @required this.animating,
    @required this.thickness,
    @required this.isLandscape,
  })  : _b = b,
        _a = a,
        super(key: key);

  final double _b;
  final double _a;
  final double delta;
  final bool animate;
  final bool animating;
  final double thickness;
  final bool isLandscape;

  @override
  _LissajousState createState() => _LissajousState();
}

class _LissajousState extends State<Lissajous> {
  List<Offset> points = [];
  double loopi = 0;
  double r, n, d, c, transformx, transformy;
  double looplength = 2 * pi;
  double tx, ty;
  bool orientationChanged = true;

  void dispose() {
    super.dispose();
  }

  void clearscreen() {
    points.clear();
    looplength = 2 * pi;
    looplength += loopi;
  }

  void clear() {
    clearscreen();
    loopi = 0;
    looplength = 2 * pi;
  }

  nextStep() {
    if (loopi >= looplength) {
      clear();
    }
    setState(() {
      sleep(Duration(milliseconds: 10));
      loopi += 0.01;
      points.add(Offset(r * sin(widget._a * loopi + widget.delta),
              r * sin(widget._b * loopi))
          .translate(tx.roundToDouble(), ty.roundToDouble()));
    });
  }

  @override
  Widget build(BuildContext context) {
    tx = widget.isLandscape
        ? MediaQuery.of(context).size.width / 3
        : MediaQuery.of(context).size.width / 2;
    ty = MediaQuery.of(context).size.height / 3;
    r = (widget.isLandscape
            ? MediaQuery.of(context).size.width / 4
            : MediaQuery.of(context).size.width / 2.5)
        .roundToDouble();

    if (widget.animating) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        nextStep();
      });
    }
    if (!(widget.isLandscape ^ orientationChanged)) {
      clear();
      orientationChanged = !orientationChanged;
    }

    return Transform.scale(
      scale: widget.isLandscape ? 0.5 : 1,
      child: CustomPaint(
        painter: LissajousPainter(
          widget._b,
          widget._a,
          tx.roundToDouble(),
          ty.roundToDouble(),
          r,
          widget.delta,
          widget.animate,
          points,
          widget.thickness,
        ),
        child: Container(),
      ),
    );
  }
}

class LissajousPainter extends CustomPainter {
  double d, r, n, c;
  double k, transformx, transformy;
  List<Offset> points = [];
  bool animate;
  double thickness;
  LissajousPainter(
    this.d,
    this.n,
    this.transformx,
    this.transformy,
    this.r,
    this.c,
    this.animate,
    points,
    this.thickness,
  ) {
    this.points = new List<Offset>.from(points);
    k = n / d;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    paint.strokeWidth = thickness;
    if (!animate) {
      this.points.clear();
      for (double i = 0; i <= 2 * pi; i += 0.01) {
        this.points.add(Offset(r * sin(n * i + c), r * sin(d * i))
            .translate(transformx, transformy));
      }
    }
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(LissajousPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(LissajousPainter oldDelegate) => false;
}
