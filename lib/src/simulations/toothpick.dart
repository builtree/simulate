import 'package:flutter/material.dart';
import 'package:collection/equality.dart';

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

  Toothpick compareEnd1(otherPicks) {
    otherPicks.forEach((pick) {
      if (!listEq(pick.center, this.center)) {
        if (listEq(pick.end1, this.end1) ||
            listEq(pick.end2, this.end1) ||
            listEq(pick.center, this.end1)) {
          return;
        }
      }
    });
    return Toothpick(end1, !this.alignment);
  }

  Toothpick compareEnd2(otherPicks) {
    otherPicks.forEach((pick) {
      if (!listEq(pick.center, this.center)) {
        if (listEq(pick.end1, this.end2) ||
            listEq(pick.end2, this.end2) ||
            listEq(pick.center, this.end2)) {
          return;
        }
      }
    });
    return Toothpick(end2, !this.alignment);
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
  // Toothpick toothpick = new Toothpick([100.0, 100.0], true);
  // Toothpick toothpick = new Toothpick([MediaQuery.of(context).size.width/2, MediaQuery.of(context).size.height/2], true);
  addStep() {
    setState(() {
      step++;
      prevToothPicks.add([]..addAll(activeToothPicks));
      activeToothPicks.clear();
      print(prevToothPicks[prevToothPicks.length - 1]);
      prevToothPicks[prevToothPicks.length - 1].forEach((pick) {
        activeToothPicks.add(pick.compareEnd1(toothPicks));
        // print(pick.compareEnd1(toothPicks).end1);
        activeToothPicks.add(pick.compareEnd2(toothPicks));
      });
      toothPicks += prevToothPicks[prevToothPicks.length - 1];
    });
  }

  subtract() {
    if (step == 0) {
      return;
    }
    setState(() {
      step--;
    });
  }

  @override
  Widget build(BuildContext context) {
    Toothpick toothpick = new Toothpick([
      (MediaQuery.of(context).size.width) / 2,
      (MediaQuery.of(context).size.height) / 2
    ], true);
    if (step == 0) {
      activeToothPicks.add(toothpick);
    }
    // print(activeToothPicks.length);
    return Scaffold(
      appBar: AppBar(
        title: Text("ToothPick Pattern"),
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: CustomPaint(
            painter: ToothpickPainter(activeToothPicks, toothPicks),
            child: Container(),
          ),
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                subtract();
              },
            ),
            Expanded(
              child: Center(
                child: Text(step.toString()),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                addStep();
              },
            ),
          ],
        ),
      ]),
    );
  }
}

class ToothpickPainter extends CustomPainter {
  var activeToothpicks = new List<Toothpick>();
  var toothpicks = new List<Toothpick>();
  ToothpickPainter(this.activeToothpicks, this.toothpicks);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.strokeWidth = 1;
    for (int i = 0; i < toothpicks.length; i++) {
      canvas.drawLine(Offset(toothpicks[i].end1[0], toothpicks[i].end1[1]),
          Offset(toothpicks[i].end2[0], toothpicks[i].end2[1]), paint);
    }
    paint.color = Colors.blue;
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
