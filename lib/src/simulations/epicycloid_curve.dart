import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

GlobalKey<_EpicycloidState> globalKey = GlobalKey<_EpicycloidState>();

class EpicycloidCurve extends StatefulWidget {
  @override
  _EpicycloidCurveState createState() => _EpicycloidCurveState();
}

class _EpicycloidCurveState extends State<EpicycloidCurve> {
  double factor = 0;
  double total = 0;
  bool animatefactor = false;
  bool animatepoints = false;
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
            designSize: Size(434.0, 924.0),
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
                'Epicycloid Pattern (Pencil of Lines)',
                style: Theme.of(context).textTheme.headline6,
              ),
              centerTitle: true,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Visibility(
                visible: animatefactor || animatepoints,
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
                            factor = globalKey.currentState.widget.factor;
                            total = globalKey.currentState.widget.total;
                          });
                        }),
                    FloatingActionButton(
                      heroTag: null,
                      child: Icon(
                        Icons.replay,
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          if (animatefactor) {
                            factor = 0;
                          }
                          if (animatepoints) {
                            total = 0;
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
                ScreenUtil().setHeight(924 / 5),
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
                      Epicycloid(
                        factor: factor,
                        total: total,
                        animatefactor: animatefactor,
                        animatepoints: animatepoints,
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
                              'Animate with Factor:',
                            ),
                            Checkbox(
                              onChanged: (animating)
                                  ? null
                                  : (_) {
                                      setState(() {
                                        animatefactor = !animatefactor;
                                      });
                                    },
                              activeColor: Colors.red,
                              value: animatefactor,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Animate with Points:',
                            ),
                            Checkbox(
                              onChanged: (animating)
                                  ? null
                                  : (_) {
                                      setState(() {
                                        animatepoints = !animatepoints;
                                      });
                                    },
                              activeColor: Colors.red,
                              value: animatepoints,
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
                max: 500,
                divisions: 500,
                activeColor: Theme.of(context).colorScheme.secondary,
                inactiveColor: Colors.grey,
                onChanged: (animating)
                    ? null
                    : (value) {
                        setState(() {
                          total = double.parse(value.toStringAsFixed(1));
                        });
                      },
                value: total,
              ),
              Center(
                child: Text(
                  (animating && animatepoints)
                      ? "Points: Animating"
                      : "Points: ${total.toInt()}",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              Slider(
                min: 0,
                max: 51,
                divisions: 510,
                activeColor: Theme.of(context).colorScheme.secondary,
                inactiveColor: Colors.grey,
                onChanged: (animating)
                    ? null
                    : (value) {
                        setState(() {
                          factor = double.parse(value.toStringAsFixed(1));
                        });
                      },
                value: factor,
              ),
              Center(
                child: Text(
                  (animating && animatefactor)
                      ? "Factor: Animating"
                      : "Factor: ${factor.toStringAsFixed(1)}",
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

class Epicycloid extends StatefulWidget {
  Epicycloid({
    Key key,
    @required this.factor,
    @required this.total,
    @required this.animatefactor,
    @required this.animatepoints,
    @required this.animating,
    @required this.isLandscape,
  }) : super(key: key);

  double factor;
  double total;
  final bool animatefactor;
  final bool animatepoints;
  final bool animating;
  final bool isLandscape;

  @override
  _EpicycloidState createState() => _EpicycloidState();
}

class _EpicycloidState extends State<Epicycloid> {
  nextStep() async {
    await Future.delayed(Duration(milliseconds: 10));
    if (this.mounted) {
      setState(() {
        if (widget.animatefactor) {
          widget.factor += 0.01;
        }
        if (widget.animatepoints) {
          widget.total += 0.3;
        }
        if (widget.factor > 51) {
          widget.factor = 0;
        }
        if (widget.total > 500) {
          widget.total = 0;
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
            painter: EpicycloidPainter(
                widget.factor,
                widget.total,
                (widget.isLandscape
                        ? MediaQuery.of(context).size.width / 5
                        : MediaQuery.of(context).size.width / 2.4)
                    .roundToDouble(),
                (widget.isLandscape
                        ? MediaQuery.of(context).size.width / 3
                        : MediaQuery.of(context).size.width / 2)
                    .roundToDouble(),
                (MediaQuery.of(context).size.height / 3).roundToDouble(),
                Theme.of(context).colorScheme.secondary),
            child: Container(),
          ),
        ),
        Visibility(
          visible: widget.animatepoints,
          child: Positioned(
            right: 15,
            top: 40,
            child: Text("Points: ${widget.total.toInt()}"),
          ),
        ),
        Visibility(
          visible: widget.animatefactor,
          child: Positioned(
            left: 12,
            top: 40,
            child: Text("Factor: ${widget.factor.toStringAsFixed(1)}"),
          ),
        ),
      ],
    );
  }
}

class EpicycloidPainter extends CustomPainter {
  List<Offset> points = [];
  double total, factor;
  double radius, tx, ty;
  Color color;

  EpicycloidPainter(
    this.factor,
    this.total,
    this.radius,
    this.tx,
    this.ty,
    this.color,
  );

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    paint.strokeWidth = 3;
    paint.style = PaintingStyle.stroke;

    var paint2 = Paint();
    paint2.color = color;
    paint2.strokeWidth = 1;
    double x = 2 * pi / total;
    double angle = pi;

    for (int i = 0; i < total; ++i) {
      points.add(
          Offset(radius * cos(angle), radius * sin(angle)).translate(tx, ty));
      angle = angle + x;
    }
    for (double i = 0; i < total; i += 1) {
      canvas.drawLine(points[(i % total).toInt()],
          points[((i * factor) % total).toInt()], paint2);
    }
    canvas.drawCircle(Offset(tx, ty), radius, paint);
  }

  @override
  bool shouldRepaint(EpicycloidPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(EpicycloidPainter oldDelegate) => false;
}
