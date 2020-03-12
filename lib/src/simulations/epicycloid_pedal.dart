import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

GlobalKey<_EpicycloidPedalState> globalKey = GlobalKey<_EpicycloidPedalState>();

List<Offset> ys = [];

class EpicycloidPedalCurve extends StatefulWidget {
  @override
  _EpicycloidPedalCurveState createState() => _EpicycloidPedalCurveState();
}

class _EpicycloidPedalCurveState extends State<EpicycloidPedalCurve> {
  double time = 0;
  double amplitudeRadius = 35;
  double _k = 1;
  double f = 0.01;
  double _scaleAmount = 1;
  bool animate = false;
  bool animating = false;

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

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 720.0,
      height: 1600.0,
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
        centerTitle: true,
        title: Text(
          'Epicycloid Pedal Curve',
          style: Theme.of(context).textTheme.title,
        ),
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
                  heroTag: Null,
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
                heroTag: Null,
                child: Icon(
                  Icons.highlight_off,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                onPressed: () {
                  setState(() {
                    ys.clear();
                  });
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: ScreenUtil().setHeight(1600 / 4.0),
        child: Container(
          child: Material(
            elevation: 30,
            color: Theme.of(context).primaryColor,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Slider(
                  min: 1,
                  max: 5,
                  divisions: 100,
                  activeColor: Theme.of(context).accentColor,
                  inactiveColor: Colors.grey,
                  onChanged: (value) {
                    setState(() {
                      _k = double.parse(value.toStringAsFixed(1));
                    });
                    ys.clear();
                  },
                  value: _k,
                ),
                Center(
                  child: Text(
                    "k: " + _k.toString(),
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ),
                Slider(
                  min: 10,
                  max: 60,
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
                  min: 0.01,
                  max: 2,
                  activeColor: Theme.of(context).accentColor,
                  inactiveColor: Colors.grey,
                  onChanged: (value) {
                    setState(() {
                      _scaleAmount = value;
                    });
                  },
                  value: _scaleAmount,
                ),
                Center(
                  child: Text(
                    "- Scale +",
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ),
                Slider(
                  min: 0,
                  max: 0.1,
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            EpicycloidPedal(
              k: _k,
              amplitudeRadius: amplitudeRadius,
              f: f,
              scaleAmount: _scaleAmount,
              animate: animate,
              animating: animating,
              key: globalKey,
              context: context,
            ),
            Positioned(
              top: 5,
              left: 5,
              child: Visibility(
                visible: animate,
                child: Text(
                  'radius ~ ${(amplitudeRadius / _k).toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.subtitle,
                ),
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

class EpicycloidPedal extends StatefulWidget {
  EpicycloidPedal({
    @required double k,
    @required double amplitudeRadius,
    @required double f,
    @required double scaleAmount,
    @required this.animate,
    @required this.animating,
    Key key,
    @required this.context,
  })  : _k = k,
        amplitudeRadius = amplitudeRadius,
        f = f,
        _scaleAmount = scaleAmount,
        super(key: key);

  final double _k;
  final double amplitudeRadius;
  final double f;
  final double _scaleAmount;
  final bool animate;
  final bool animating;
  final BuildContext context;
  @override
  _EpicycloidPedalState createState() => _EpicycloidPedalState();
}

class _EpicycloidPedalState extends State<EpicycloidPedal> {
  List<Offset> points = [];
  double r, transformx, transformy;
  double time = 0;

  void dispose() {
    super.dispose();
  }

  void clearscreen() {
    points.clear();
    ys.clear();
    time = 0;
  }

  update() {
    setState(() {
      time -= widget.f;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animating) {
      WidgetsBinding.instance.addPostFrameCallback((_) => update());
    }
    return Container(
      child: Transform.scale(
        scale: widget._scaleAmount,
        child: CustomPaint(
          painter: EpicycloidPedalPainter(
            widget._k,
            widget.amplitudeRadius,
            time,
            (MediaQuery.of(context).size.width / 2).roundToDouble(),
            (MediaQuery.of(context).size.height / 3).roundToDouble(),
            widget.animate,
            points,
            context,
          ),
          child: Container(),
        ),
      ),
    );
  }
}

class EpicycloidPedalPainter extends CustomPainter {
  double radius, time, r;
  Offset smallCenter;
  double _k, transformx, transformy;
  BuildContext context;
  List<Offset> points = [];
  bool animate;

  EpicycloidPedalPainter(
    this._k,
    this.r,
    this.time,
    this.transformx,
    this.transformy,
    this.animate,
    points,
    this.context,
  ) {
    radius = r / _k;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset coor = new Offset(transformx, transformy);
    if (!animate) {
      var paint = Paint();
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 2;
      this.points.clear();
      paint.color = Theme.of(context).accentColor;
      canvas.drawCircle(Offset(transformx, transformy), r.toDouble(), paint);
      paint.color = Colors.red;
      for (double loopi = 0; loopi <= 50 * pi; loopi += 0.01) {
        this.points.add(Offset(
                (radius * (((_k + 1) * cos(loopi)) - cos((_k + 1) * loopi))),
                (radius * (((_k + 1) * sin(loopi)) - sin((_k + 1) * loopi))))
            .translate(transformx, transformy));
      }
      canvas.drawPoints(PointMode.polygon, points, paint);
    } else {
      Paint paint = new Paint();
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 2;
      paint.color = Theme.of(context).accentColor;
      canvas.drawCircle(coor, r.toDouble(), paint);
      smallCenter = Offset((r + radius) * cos(time), (r + radius) * sin(time))
          .translate(transformx, transformy);
      coor += Offset((radius * (((_k + 1) * cos(time)) - cos((_k + 1) * time))),
          (radius * (((_k + 1) * sin(time)) - sin((_k + 1) * time))));
      paint.color = Colors.blue;
      canvas.drawCircle(smallCenter, radius, paint);
      canvas.drawLine(smallCenter, coor, paint);
      smallCenter = Offset((r + radius) * cos(time), (r + radius) * sin(time));
      ys.insert(0, coor);
      ys.forEach((value) {
        points.add(value);
      });
      paint.color = Colors.red;
      canvas.drawPoints(PointMode.polygon, points, paint);
    }
  }

  @override
  bool shouldRepaint(EpicycloidPedalPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(EpicycloidPedalPainter oldDelegate) => false;
}
