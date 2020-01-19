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
  // bool doNotRefresh = f;
  bool animating = false;
  double thickness = 2;
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible: animate,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                  heroTag: 0,
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
                    // doNotRefresh = true;
                    setState(() {
                      animating = !animating;
                    });
                  }),
              FloatingActionButton.extended(
                heroTag: 1,
                label: Text(
                  'Clear',
                  style: TextStyle(
                    color: Colors.black,
                  ),
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
      bottomNavigationBar: Container(
        height: ScreenUtil.instance.height / 5,
        child: Material(
          elevation: 30,
          color: Theme.of(context).primaryColor,
          child: ListView(
            padding: EdgeInsets.all(8.0),
            children: <Widget>[
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
                    style: Theme.of(context).textTheme.subtitle),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
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
            ),
            Positioned(
              top: 5,
              left: 5,
              child: Text(
                'A:B ~ ${(_a / _b).toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.subtitle,
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
                    // tristate: true,
                    activeColor: Colors.red,
                  ),
                ],
              ),
            )
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
  })  : _b = b,
        _a = a,
        super(key: key);

  final double _b;
  final double _a;
  final double delta;
  final bool animate;
  final bool animating;
  final double thickness;

  @override
  _LissajousState createState() => _LissajousState();
}

class _LissajousState extends State<Lissajous> {
  List<Offset> points = [];
  double loopi = 0;
  double r, n, d, c, transformx, transformy;
  double looplength = 2 * pi;

  @override
  // void initState() {
  //   super.initState();
  //   // r = (MediaQuery.of(context).size.width / 2.5).roundToDouble();
  //   r = 200;
  //   n = widget._a;
  //   d = widget._b;
  //   c = widget.delta;
  // }

  void dispose() {
    super.dispose();
  }

  void clearscreen() {
    points.clear();
    looplength = 2 * pi;
    looplength += loopi;
  }

  nextStep() {
    if (loopi >= looplength) {
      clearscreen();
      loopi = 0;
      looplength = 2 * pi;
    }
    setState(() {
      sleep(Duration(milliseconds: 10));
      loopi += 0.01;
      r = (MediaQuery.of(context).size.width / 2.5).roundToDouble();
      points.add(Offset(r * sin(widget._a * loopi + widget.delta),
              r * sin(widget._b * loopi))
          .translate((MediaQuery.of(context).size.width / 2).roundToDouble(),
              (MediaQuery.of(context).size.height / 3).roundToDouble()));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animating) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        nextStep();
      });
    }
    return CustomPaint(
      painter: LissajousPainter(
        widget._b,
        widget._a,
        (MediaQuery.of(context).size.width / 2).roundToDouble(),
        (MediaQuery.of(context).size.height / 3).roundToDouble(),
        (MediaQuery.of(context).size.width / 2.5).roundToDouble(),
        widget.delta,
        widget.animate,
        points,
        widget.thickness,
      ),
      child: Container(),
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
      for (double i = 0; i < 2 * pi; i += 0.01) {
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
