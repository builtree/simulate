import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

GlobalKey<_NormalEpicycloidState> globalKey =
    GlobalKey<_NormalEpicycloidState>();

List<Offset> ys = [];

class NormalEpicycloidCurve extends StatefulWidget {
  @override
  _NormalEpicycloidCurveState createState() => _NormalEpicycloidCurveState();
}

class _NormalEpicycloidCurveState extends State<NormalEpicycloidCurve> {
  double time = 0;
  int innerRadius = 50;
  int outerRadius = 50;
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
          'Epicycloid Curve',
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
                  min: (innerRadius ~/ 10).toDouble(),
                  max: innerRadius.toDouble(),
                  activeColor: Theme.of(context).accentColor,
                  inactiveColor: Colors.grey,
                  onChanged: (value) {
                    setState(() {
                      outerRadius = value.toInt();
                    });
                    ys.clear();
                  },
                  value: outerRadius.toDouble(),
                ),
                Center(
                  child: Text(
                    "r: " + outerRadius.toString(),
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ),
                Slider(
                  min: 10,
                  max: 100,
                  activeColor: Theme.of(context).accentColor,
                  inactiveColor: Colors.grey,
                  onChanged: (value) {
                    outerRadius = value.toInt();
                    setState(() {
                      innerRadius = value.toInt();
                    });
                    ys.clear();
                  },
                  value: innerRadius.toDouble(),
                ),
                Center(
                  child: Text(
                    "R: " + innerRadius.toString(),
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
            NormalEpicycloid(
              outerRadius: outerRadius,
              innerRadius: innerRadius,
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
                child: Text(
                  'k ~ ${(innerRadius / outerRadius).toStringAsFixed(2)}',
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

class NormalEpicycloid extends StatefulWidget {
  NormalEpicycloid({
    @required int outerRadius,
    @required int innerRadius,
    @required double f,
    @required double scaleAmount,
    @required this.animate,
    @required this.animating,
    Key key,
    @required this.context,
  })  : outerRadius = outerRadius,
        innerRadius = innerRadius,
        f = f,
        _scaleAmount = scaleAmount,
        super(key: key);

  final int outerRadius;
  final int innerRadius;
  final double f;
  final double _scaleAmount;
  final bool animate;
  final bool animating;
  final BuildContext context;
  @override
  _NormalEpicycloidState createState() => _NormalEpicycloidState();
}

class _NormalEpicycloidState extends State<NormalEpicycloid> {
  List<Offset> points = [];
  double transformx, transformy;
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
          painter: NormalEpicycloidPainter(
            widget.outerRadius,
            widget.innerRadius,
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

class NormalEpicycloidPainter extends CustomPainter {
  int innerRadius, outerRadius;
  Offset smallCenter;
  double k, transformx, transformy, time;
  BuildContext context;
  List<Offset> points = [];
  bool animate;

  NormalEpicycloidPainter(
    this.outerRadius,
    this.innerRadius,
    this.time,
    this.transformx,
    this.transformy,
    this.animate,
    points,
    this.context,
  ) {
    k = innerRadius / outerRadius;
  }

  int getGCD(int n1, int n2) {
    if (n2 == 0) {
      return n1;
    }
    return getGCD(n2, n1 % n2);
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
      canvas.drawCircle(
          Offset(transformx, transformy), innerRadius.toDouble(), paint);
      paint.color = Colors.red;
      for (double loopi = 0;
          loopi <= (innerRadius / getGCD(innerRadius, outerRadius)) * 2 * pi;
          loopi += 0.01) {
        this.points.add(Offset(
                (outerRadius * (((k + 1) * cos(loopi)) - cos((k + 1) * loopi))),
                (outerRadius * (((k + 1) * sin(loopi)) - sin((k + 1) * loopi))))
            .translate(transformx, transformy));
      }
      canvas.drawPoints(PointMode.polygon, points, paint);
    } else {
      Paint paint = new Paint();
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 2;
      paint.color = Theme.of(context).accentColor;
      canvas.drawCircle(coor, innerRadius.toDouble(), paint);
      smallCenter = Offset((innerRadius + outerRadius) * cos(time),
              (innerRadius + outerRadius) * sin(time))
          .translate(transformx, transformy);
      coor += Offset(
          (outerRadius * (((k + 1) * cos(time)) - cos((k + 1) * time))),
          (outerRadius * (((k + 1) * sin(time)) - sin((k + 1) * time))));
      paint.color = Colors.blue;
      canvas.drawCircle(smallCenter, outerRadius.toDouble(), paint);
      canvas.drawLine(smallCenter, coor, paint);
      smallCenter = Offset((innerRadius + outerRadius) * cos(time),
          (innerRadius + outerRadius) * sin(time));
      ys.insert(0, coor);
      ys.forEach((value) {
        points.add(value);
      });
      paint.color = Colors.red;
      canvas.drawPoints(PointMode.polygon, points, paint);
    }
  }

  @override
  bool shouldRepaint(NormalEpicycloidPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(NormalEpicycloidPainter oldDelegate) => false;
}
