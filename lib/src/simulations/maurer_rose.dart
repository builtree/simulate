import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
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
  bool animateN = false;
  bool animateD = false;
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
                'MaurerRose Pattern',
                style: Theme.of(context).textTheme.headline6,
              ),
              centerTitle: true,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Visibility(
                visible: animateN || animateD,
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
                          if (animateN) {
                            n = 0;
                          }
                          if (animateD) {
                            d = 0;
                          }
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
                      MaurerRose(
                        d: d,
                        n: n,
                        // dd: dd,
                        // dn: dn,
                        animateN: animateN,
                        animateD: animateD,
                        animating: animating,
                        key: globalKey,
                        isLandscape: isLandscape(),
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
                                        animateN = !animateN;
                                      });
                                    },
                              activeColor: Colors.red,
                              value: animateN,
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
                                        animateD = !animateD;
                                      });
                                    },
                              activeColor: Colors.red,
                              value: animateD,
                            ),
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
                max: 20,
                divisions: 200,
                activeColor: Theme.of(context).colorScheme.secondary,
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
                  (animating && animateN)
                      ? "N: Animating"
                      : "N: ${n.toStringAsFixed(1)}",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              Slider(
                min: 0,
                max: 100,
                divisions: 100,
                activeColor: Theme.of(context).colorScheme.secondary,
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
                  (animating && animateD)
                      ? "D: Animating"
                      : "D: ${d.toStringAsFixed(1)}",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              // Slider(
              //   min: 0.001,
              //   max: 0.01,
              //   divisions: 9,
              //   activeColor: Theme.of(context).colorScheme.secondary,
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
              //     style: Theme.of(context).textTheme.subtitle2,
              //   ),
              // ),
              // Slider(
              //   min: 0.001,
              //   max: 0.01,
              //   divisions: 9,
              //   activeColor: Theme.of(context).colorScheme.secondary,
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
              //     style: Theme.of(context).textTheme.subtitle2,
              //   ),
              // ),
            ],
          ),
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
    @required this.animateN,
    @required this.animateD,
    @required this.animating,
    @required this.isLandscape,
  }) : super(key: key);

  double d;
  double n;
  // double dd;
  // double dn;
  final bool animateN;
  final bool animateD;
  final bool animating;
  final bool isLandscape;

  @override
  MaurerRoseState createState() => MaurerRoseState();
}

class MaurerRoseState extends State<MaurerRose> {
  nextStep() async {
    await Future.delayed(Duration(milliseconds: 10));
    if (this.mounted) {
      setState(() {
        if (widget.animateN) {
          widget.n += 0.003;
        }
        if (widget.animateD) {
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
        Transform.scale(
          scale: widget.isLandscape ? 0.7 : 1,
          child: CustomPaint(
            painter: MaurerRosePainter(
              widget.d,
              widget.n,
              (widget.isLandscape
                      ? MediaQuery.of(context).size.width / 3
                      : MediaQuery.of(context).size.width / 2)
                  .roundToDouble(),
              (MediaQuery.of(context).size.height / 3).roundToDouble(),
              Theme.of(context).colorScheme.secondary,
            ),
            child: Container(),
          ),
        ),
        Visibility(
          visible: widget.animateN,
          child: Positioned(
            left: 12,
            top: 40,
            child: Text("N: ${widget.n.toStringAsFixed(1)}"),
          ),
        ),
        Visibility(
          visible: widget.animateD,
          child: Positioned(
            right: 15,
            top: 40,
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
