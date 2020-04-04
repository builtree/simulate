import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

GlobalKey<MaurerRoseState> globalKey = GlobalKey<MaurerRoseState>();

class MaurerRoseCurve extends StatefulWidget {
  @override
  MaurerRoseCurveState createState() => MaurerRoseCurveState();
}

class MaurerRoseCurveState extends State<MaurerRoseCurve> {
  double n = 0;
  double d = 0;
  // double dn = 0.001;
  // double dd = 0.001;
  bool animate_N = false;
  bool animate_D = false;
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
          'MaurerRose Pattern',
          style: Theme.of(context).textTheme.title,
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible: animate_N || animate_D,
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
                      d = globalKey.currentState.widget.d;
                      n = globalKey.currentState.widget.n;
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
                    if (animate_N) {
                      n = 0;
                    }
                    if (animate_D) {
                      d = 0;
                    }
                  });
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: ScreenUtil().setHeight(1024 / 5),
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
                max: 20,
                divisions: 200,
                activeColor: Theme.of(context).accentColor,
                inactiveColor: Colors.grey,
                onChanged: (animating)
                    ? null
                    : (value) {
                        setState(() {
                          n = double.parse(value.toStringAsFixed(1));
                        });
                      },
                value: n,
              ),
              Center(
                child: Text(
                  (animating && animate_N)
                      ? "N: Animating"
                      : "N: ${n.toStringAsFixed(1)}",
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
              Slider(
                min: 0,
                max: 100,
                divisions: 100,
                activeColor: Theme.of(context).accentColor,
                inactiveColor: Colors.grey,
                onChanged: (animating)
                    ? null
                    : (value) {
                        setState(() {
                          d = double.parse(value.toStringAsFixed(1));
                        });
                      },
                value: d,
              ),
              Center(
                child: Text(
                  (animating && animate_D)
                      ? "D: Animating"
                      : "D: ${d.toStringAsFixed(1)}",
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
              // Slider(
              //   min: 0.001,
              //   max: 0.01,
              //   divisions: 9,
              //   activeColor: Theme.of(context).accentColor,
              //   inactiveColor: Colors.grey,
              //   onChanged: (value) {
              //     setState(() {
              //       dn = double.parse(value.toStringAsFixed(3));
              //     });
              //   },
              //   value: dn,
              // ),
              // Center(
              //   child: Text(
              //     "dn: ${dn.toStringAsFixed(3)}",
              //     style: Theme.of(context).textTheme.subtitle,
              //   ),
              // ),
              // Slider(
              //   min: 0.001,
              //   max: 0.01,
              //   divisions: 9,
              //   activeColor: Theme.of(context).accentColor,
              //   inactiveColor: Colors.grey,
              //   onChanged: (value) {
              //     setState(() {
              //       dd = double.parse(value.toStringAsFixed(3));
              //     });
              //   },
              //   value: dd,
              // ),
              // Center(
              //   child: Text(
              //     "dd: ${dd.toStringAsFixed(3)}",
              //     style: Theme.of(context).textTheme.subtitle,
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            MaurerRose(
              d: d,
              n: n,
              // dd: dd,
              // dn: dn,
              animate_N: animate_N,
              animate_D: animate_D,
              animating: animating,
              key: globalKey,
            ),
            Positioned(
              left: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Animate with N:',
                  ),
                  Checkbox(
                    onChanged: (animating)
                        ? null
                        : (_) {
                            setState(() {
                              animate_N = !animate_N;
                            });
                          },
                    activeColor: Colors.red,
                    value: animate_N,
                  ),
                ],
              ),
            ),
            Positioned(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Animate with D:',
                  ),
                  Checkbox(
                    onChanged: (animating)
                        ? null
                        : (_) {
                            setState(() {
                              animate_D = !animate_D;
                            });
                          },
                    activeColor: Colors.red,
                    value: animate_D,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MaurerRose extends StatefulWidget {
  MaurerRose({
    Key key,
    @required this.d,
    @required this.n,
    // @required this.dd,
    // @required this.dn,
    @required this.animate_N,
    @required this.animate_D,
    @required this.animating,
  }) : super(key: key);

  double d;
  double n;
  // double dd;
  // double dn;
  final bool animate_N;
  final bool animate_D;
  final bool animating;

  @override
  MaurerRoseState createState() => MaurerRoseState();
}

class MaurerRoseState extends State<MaurerRose> {
  nextStep() {
    setState(() {
      sleep(Duration(milliseconds: 10));
      if (widget.animate_N) {
        widget.n += 0.003;
      }
      if (widget.animate_D) {
        widget.d += 0.005;
      }
      if (widget.n > 20) {
        widget.n = 0;
      }
      if (widget.d > 100) {
        widget.d = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animating) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        nextStep();
      });
    }
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CustomPaint(
          painter: MaurerRosePainter(
            widget.d,
            widget.n,
            (MediaQuery.of(context).size.width / 2).roundToDouble(),
            (MediaQuery.of(context).size.height / 3).roundToDouble(),
            Theme.of(context).accentColor,
          ),
          child: Container(),
        ),
        Visibility(
          visible: widget.animate_N,
          child: Positioned(
            bottom: 60,
            child: Text("N: ${widget.n.toStringAsFixed(1)}"),
          ),
        ),
        Visibility(
          visible: widget.animate_D,
          child: Positioned(
            bottom: 40,
            child: Text("D: ${widget.d.toStringAsFixed(1)}"),
          ),
        ),
      ],
    );
  }
}

class MaurerRosePainter extends CustomPainter {
  double d, n, c;
  double k, transformx, transformy;
  List<Offset> points = [];
  List<Offset> points2 = [];
  Color color;
  double q, x, y;
  int theta, r = 300;

  MaurerRosePainter(
    this.d,
    this.n,
    this.transformx,
    this.transformy,
    this.color,
  ) {
    k = n / d;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (theta = 0; theta <= 360; theta++) {
      k = theta * d * pi / 180;
      q = r * sin(n * k);
      x = q * cos(k);
      y = q * sin(k);
      this
          .points
          .add(Offset(x / 1.5, y / 1.5).translate(transformx, transformy));
    }
    canvas.drawPoints(PointMode.polygon, points, paint);

    var paint2 = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    for (theta = 0; theta <= 360; theta++) {
      k = theta * pi / 180;
      q = r * sin(n * k);
      x = q * cos(k);
      y = q * sin(k);
      this
          .points2
          .add(Offset(x / 1.5, y / 1.5).translate(transformx, transformy));
    }
    canvas.drawPoints(PointMode.polygon, points2, paint2);
  }

  @override
  bool shouldRepaint(MaurerRosePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MaurerRosePainter oldDelegate) => false;
}
