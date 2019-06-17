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
  List<Toothpick> activeToothPicks = [];
  var prevActiveToothPicks = [];
  var toothPicks = [];
  // Toothpick toothpick = new Toothpick([100.0, 100.0], true);
  // Toothpick toothpick = new Toothpick([MediaQuery.of(context).size.width/2, MediaQuery.of(context).size.height/2], true);
  add() {
    setState(() {
      step++;
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
    ], false);
    activeToothPicks.clear();
    activeToothPicks.add(toothpick);
    print(activeToothPicks.length);
    return Scaffold(
      appBar: AppBar(
        title: Text("ToothPick Pattern"),
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: CustomPaint(
            painter: ToothpickPainter(activeToothPicks),
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
                add();
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
  ToothpickPainter(this.activeToothpicks);
  addpicks(){
    this.activeToothpicks.add(this.activeToothpicks[0].compareEnd1([]));
  }
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.strokeWidth = 2;
    paint.color = Colors.blue;
    addpicks();
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
