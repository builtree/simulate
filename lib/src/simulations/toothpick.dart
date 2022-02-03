import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Function listEq = const DeepCollectionEquality().equals;

class Toothpick {
  bool alignment;
  var end1 = new List(2);
  var end2 = new List(2);
  var center = new List(2);
  Toothpick(this.center, this.alignment) {
    if (alignment == true) {
      this.end1[0] = center[0];
      this.end1[1] = center[1] - 20;
      this.end2[0] = center[0];
      this.end2[1] = center[1] + 20;
    } else {
      this.end1[0] = center[0] - 20;
      this.end1[1] = center[1];
      this.end2[0] = center[0] + 20;
      this.end2[1] = center[1];
    }
  }

  bool compareEnd1(otherPicks) {
    int flag;
    otherPicks.forEach((pick) {
      if (!listEq(pick.center, this.center)) {
        if (listEq(pick.end1, this.end1) |
            listEq(pick.end2, this.end1) |
            listEq(pick.center, this.end1)) {
          flag = 1;
        }
      }
    });
    if (flag == 1) {
      return false;
    } else {
      return true;
    }
  }

  bool compareEnd2(otherPicks) {
    int flag = 0;
    otherPicks.forEach((pick) {
      if (!listEq(pick.center, this.center)) {
        if (listEq(pick.end1, this.end2) |
            listEq(pick.end2, this.end2) |
            listEq(pick.center, this.end2)) {
          flag = 1;
        }
      }
    });
    if (flag == 1) {
      return false;
    } else {
      return true;
    }
  }
}

class ToothpickPattern extends StatefulWidget {
  @override
  _ToothpickPatternState createState() => _ToothpickPatternState();
}

class _ToothpickPatternState extends State<ToothpickPattern> {
  int step = 0;
  var activeToothPicks = new List<Toothpick>();
  var prevToothPicks = new List<List<Toothpick>>();
  var toothPicks = new List<Toothpick>();
  var extra;
  double _scaleAmount = 1.0;

  addStep() {
    setState(() {
      step++;
      prevToothPicks.add([]..addAll(activeToothPicks));
      toothPicks += prevToothPicks[prevToothPicks.length - 1];
      activeToothPicks.clear();
      prevToothPicks[prevToothPicks.length - 1].forEach((pick) {
        extra = pick.compareEnd1(toothPicks);
        if (extra) {
          activeToothPicks += [new Toothpick(pick.end1, !pick.alignment)];
        }
        extra = pick.compareEnd2(toothPicks);
        if (extra) {
          activeToothPicks += [new Toothpick(pick.end2, !pick.alignment)];
        }
      });
    });
  }

  subtract() {
    if (step == 0) {
      return;
    }
    setState(() {
      step--;
      activeToothPicks.clear();
      activeToothPicks += prevToothPicks[prevToothPicks.length - 1];
      for (int i = 0;
          i < prevToothPicks[prevToothPicks.length - 1].length;
          i++) {
        toothPicks.removeLast();
      }
      prevToothPicks.removeLast();
    });
  }

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
    if (step == 1) {
      activeToothPicks.add(new Toothpick([
        (MediaQuery.of(context).size.width / 2).roundToDouble(),
        (MediaQuery.of(context).size.height / 2 - 100).roundToDouble()
      ], true));
    }
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
                "Toothpick Pattern",
                style: Theme.of(context).textTheme.headline6,
              ),
              centerTitle: true,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton.extended(
              onPressed: null,
              elevation: 10,
              label: Text(
                'Step: $step',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red,
            ),
            bottomNavigationBar: Material(
              elevation: 30,
              child: Container(
                height: ScreenUtil().setHeight(1024 / 9),
                color: Theme.of(context).primaryColor,
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            subtract();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            addStep();
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.zoom_out),
                          onPressed: () {
                            setState(() {
                              _scaleAmount -=
                                  _scaleAmount - 0.1 <= 0.01 ? 0 : 0.1;
                            });
                          },
                        ),
                        Expanded(
                          child: Slider(
                            value: _scaleAmount,
                            activeColor: Colors.red,
                            min: 0.01,
                            max: 2,
                            inactiveColor: Colors.grey,
                            onChanged: (value) {
                              setState(() {
                                _scaleAmount = value;
                              });
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.zoom_in),
                          onPressed: () {
                            setState(() {
                              _scaleAmount += _scaleAmount + 0.1 > 2 ? 0 : 0.1;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: Container(
              child: Transform.scale(
                scale: _scaleAmount,
                child: CustomPaint(
                  painter: ToothpickPainter(
                    activeToothPicks,
                    toothPicks,
                    Theme.of(context).colorScheme.secondary,
                  ),
                  child: Container(),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class ToothpickPainter extends CustomPainter {
  var activeToothpicks = new List<Toothpick>();
  var toothpicks = new List<Toothpick>();
  var colorTheme = new Color(0);
  ToothpickPainter(this.activeToothpicks, this.toothpicks, this.colorTheme);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.strokeWidth = 2;
    paint.color = this.colorTheme;
    for (int i = 0; i < toothpicks.length; i++) {
      canvas.drawLine(Offset(toothpicks[i].end1[0], toothpicks[i].end1[1]),
          Offset(toothpicks[i].end2[0], toothpicks[i].end2[1]), paint);
    }
    paint.color = Colors.red;
    for (int i = 0; i < activeToothpicks.length; i++) {
      canvas.drawLine(
          Offset(activeToothpicks[i].end1[0], activeToothpicks[i].end1[1]),
          Offset(activeToothpicks[i].end2[0], activeToothpicks[i].end2[1]),
          paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
