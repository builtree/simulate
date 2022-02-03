import 'dart:math';
import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    ys.clear();
    time = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // ignore: missing_return
      builder: (_, BoxConstraints constraints) {
        if (constraints.maxWidth != 0) {
          ScreenUtil.init(
            constraints,
            context: context,
            designSize: Size(720.0, 1600.0),
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
                'Epicycloid Curve',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
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
                          ys.clear();
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
                animate
                    ? ScreenUtil().setHeight(1600 / 4.0)
                    : ScreenUtil().setHeight(1600 / 6.0),
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
                      NormalEpicycloid(
                        outerRadius: outerRadius,
                        innerRadius: innerRadius,
                        f: f,
                        scaleAmount: _scaleAmount,
                        animate: animate,
                        animating: animating,
                        key: globalKey,
                        context: context,
                        isLandscape: isLandscape(),
                      ),
                      Positioned(
                        top: 5,
                        left: 5,
                        child: Visibility(
                          child: Text(
                            'k ~ ${(innerRadius / outerRadius).toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.subtitle2,
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
                              onChanged: (animating)
                                  ? null
                                  : (_) {
                                      setState(() {
                                        animate = !animate;
                                      });
                                    },
                              activeColor: Colors.red,
                              value: animate,
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
      },
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
        child: Scrollbar(
          controller: _scrollController,
          isAlwaysShown: true,
          child: ListView(
            controller: _scrollController,
            padding: EdgeInsets.all(8.0),
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Slider(
                min: 0,
                max: 50,
                activeColor: Theme.of(context).colorScheme.secondary,
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
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              Slider(
                min: 50,
                max: 100,
                activeColor: Theme.of(context).colorScheme.secondary,
                inactiveColor: Colors.grey,
                onChanged: (value) {
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
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              Visibility(
                visible: animate,
                child: Column(
                  children: <Widget>[
                    Slider(
                      min: 0,
                      max: 0.1,
                      activeColor: Theme.of(context).colorScheme.secondary,
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
            ],
          ),
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
    @required this.isLandscape,
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
  final bool isLandscape;

  @override
  _NormalEpicycloidState createState() => _NormalEpicycloidState();
}

class _NormalEpicycloidState extends State<NormalEpicycloid> {
  List<Offset> points = [];
  double transformx, transformy;
  double time = 0;
  bool orientationChanged = true;

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
    if (time <
        (widget.innerRadius / widget.innerRadius.gcd(widget.outerRadius)) *
            -2 *
            pi) {
      time = 0;
      ys.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animating) {
      WidgetsBinding.instance.addPostFrameCallback((_) => update());
    }
    if (!(widget.isLandscape ^ orientationChanged)) {
      clearscreen();
      orientationChanged = !orientationChanged;
    }

    return Container(
      child: Transform.scale(
        scale: widget.isLandscape
            ? 0.7 * widget._scaleAmount
            : widget._scaleAmount,
        child: CustomPaint(
          painter: NormalEpicycloidPainter(
            widget.outerRadius,
            widget.innerRadius,
            time,
            (widget.isLandscape
                    ? MediaQuery.of(context).size.width / 3
                    : MediaQuery.of(context).size.width / 2)
                .roundToDouble(),
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
  double transformx, transformy, time;
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
  );

  @override
  void paint(Canvas canvas, Size size) {
    Offset coor = new Offset(transformx, transformy);
    if (!animate) {
      var paint = Paint();
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 2;
      this.points.clear();
      paint.color = Theme.of(context).colorScheme.secondary;
      canvas.drawCircle(
          Offset(transformx, transformy), innerRadius.toDouble(), paint);
      paint.color = Colors.red;
      if (outerRadius != 0) {
        for (double loopi = 0;
            loopi <= (innerRadius / innerRadius.gcd(outerRadius)) * 2 * pi;
            loopi += 0.01) {
          this.points.add(Offset(
                  (((innerRadius + outerRadius) * cos(loopi)) -
                      (outerRadius *
                          cos(((innerRadius / outerRadius) + 1) * loopi))),
                  (((innerRadius + outerRadius) * sin(loopi)) -
                      (outerRadius *
                          sin(((innerRadius / outerRadius) + 1) * loopi))))
              .translate(transformx, transformy));
        }
        canvas.drawPoints(PointMode.polygon, points, paint);
      }
    } else {
      Paint paint = new Paint();
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 2;
      paint.color = Theme.of(context).colorScheme.secondary;
      canvas.drawCircle(coor, innerRadius.toDouble(), paint);
      smallCenter = Offset((innerRadius + outerRadius) * cos(time),
              (innerRadius + outerRadius) * sin(time))
          .translate(transformx, transformy);
      if (outerRadius != 0) {
        coor += Offset(
            (((innerRadius + outerRadius) * cos(time)) -
                (outerRadius * cos(((innerRadius / outerRadius) + 1) * time))),
            (((innerRadius + outerRadius) * sin(time)) -
                (outerRadius * sin(((innerRadius / outerRadius) + 1) * time))));
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
  }

  @override
  bool shouldRepaint(NormalEpicycloidPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(NormalEpicycloidPainter oldDelegate) => false;
}
