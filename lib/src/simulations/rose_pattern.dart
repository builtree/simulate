import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

GlobalKey<_RoseState> globalKey = GlobalKey<_RoseState>();

class RosePattern extends StatefulWidget {
  @override
  _RosePatternState createState() => _RosePatternState();
}

class _RosePatternState extends State<RosePattern> {
  double _n = 0;
  double _d = 0;
  double k = 0;
  double offset = 0;
  bool animate = false;
  bool animating = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
            designSize: Size(512.0, 1024.0),
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
              title: Text(
                'Rose Pattern',
                style: Theme.of(context).textTheme.headline6,
              ),
              centerTitle: true,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: EdgeInsets.all(8.0),
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
                      },
                    ),
                    FloatingActionButton(
                      heroTag: null,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.highlight_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          globalKey.currentState.clearScreen();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Visibility(
                visible: !isLandscape(),
                child: parameters(context, ScreenUtil().setHeight(1024 / 5))),
            body: Row(
              children: [
                Container(
                  width: isLandscape()
                      ? 2 * MediaQuery.of(context).size.width / 3
                      : MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      Rose(
                        d: _d,
                        n: _n,
                        c: offset,
                        animate: animate,
                        animating: animating,
                        key: globalKey,
                        isLandscape: isLandscape(),
                      ),
                      Positioned(
                        top: 5,
                        left: 5,
                        child: Text(
                          'k ~ ${(_n / _d).toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text("Animate"),
                            Checkbox(
                              onChanged: (_) {
                                setState(() {
                                  animate = !animate;
                                  if (animating)
                                    animating = (animating && animate);
                                });
                              },
                              value: animate,
                              activeColor: Colors.red,
                            )
                          ],
                        ),
                      ),
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
                max: 10,
                divisions: 1000,
                activeColor: Theme.of(context).colorScheme.secondary,
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
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              Slider(
                min: 0,
                max: 10,
                divisions: 1000,
                activeColor: Theme.of(context).colorScheme.secondary,
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
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              Slider(
                min: 0,
                max: 1,
                divisions: 100,
                activeColor: Theme.of(context).colorScheme.secondary,
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
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Rose extends StatefulWidget {
  Rose({
    Key key,
    @required this.d,
    @required this.n,
    @required this.c,
    @required this.animate,
    @required this.animating,
    @required this.isLandscape,
  }) : super(key: key);

  final double d;
  final double n;
  final double c;
  final bool animate;
  final bool animating;
  final bool isLandscape;

  @override
  _RoseState createState() => _RoseState();
}

class _RoseState extends State<Rose> {
  List<Offset> points = [];
  double loopi = 0;
  double r, k;
  double looplength = 2 * pi;
  double tx, ty;
  bool orientationChanged = true;

  void dispose() {
    super.dispose();
  }

  void clearScreen() {
    points.clear();
    looplength = 2 * pi * widget.d;
    looplength += loopi;
  }

  nextStep() {
    if (loopi >= looplength) {
      clearScreen();
      loopi = 0;
    }

    setState(() {
      if (!(widget.d == 0) && !(widget.d == 0 && widget.n == 0)) {
        if (loopi == 0) {
          looplength = 2 * pi * widget.d;
        }
        loopi += 0.04;
        k = widget.n / widget.d;
        points.add(Offset(r * (cos(k * loopi) + widget.c) * cos(loopi),
                r * (cos(k * loopi) + widget.c) * sin(loopi))
            .translate(tx.roundToDouble(), ty.roundToDouble()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    tx = widget.isLandscape
        ? MediaQuery.of(context).size.width / 3
        : MediaQuery.of(context).size.width / 2;
    ty = MediaQuery.of(context).size.height / 3;
    r = (widget.isLandscape
            ? MediaQuery.of(context).size.width / 6.2
            : MediaQuery.of(context).size.width / 4)
        .roundToDouble();

    if (widget.animating) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        nextStep();
      });
    }
    if (!(widget.isLandscape ^ orientationChanged)) {
      clearScreen();
      orientationChanged = !orientationChanged;
    }

    return Transform.scale(
      scale: widget.isLandscape ? 0.5 : 1,
      child: CustomPaint(
        painter: RosePainter(
          widget.d,
          widget.n,
          tx.roundToDouble(),
          ty.roundToDouble(),
          r,
          widget.c,
          widget.animate,
          points,
        ),
        child: Container(),
      ),
    );
  }
}

class RosePainter extends CustomPainter {
  double d, r, n, c;
  double k, transformx, transformy;
  List<Offset> points = [];
  bool animate;
  RosePainter(this.d, this.n, this.transformx, this.transformy, this.r, this.c,
      this.animate, points) {
    k = n / d;
    this.points = new List<Offset>.from(points);
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    paint.strokeWidth = 2;
    if (!animate) {
      this.points.clear();
      for (double i = 0; i < 2 * d * pi; i += 0.01) {
        points.add(
            Offset(r * (cos(k * i) + c) * cos(i), r * (cos(k * i) + c) * sin(i))
                .translate(transformx, transformy));
      }
    }
    if (points.length > 0) {
      canvas.drawPoints(PointMode.polygon, points, paint);
    }
  }

  @override
  bool shouldRepaint(RosePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(RosePainter oldDelegate) => false;
}
