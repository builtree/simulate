import 'dart:math';
import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BubbleSortBars extends StatefulWidget {
  @override
  _BubbleSortBarsState createState() => _BubbleSortBarsState();
}

class _BubbleSortBarsState extends State<BubbleSortBars> {
  int _numberOfElements = 0;
  List<int> _elements;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Bubble Sort',
          style: TextStyle(fontFamily: 'Ubuntu'),
        ),
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          child: Icon(Icons.play_arrow),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BubbleSortSim(
                      numberOfElements: _numberOfElements,
                    ),
              ),
            );
          }),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Number of Elements:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    child: TextField(
                      maxLength: 4,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _numberOfElements = int.parse(value);
                        });
                      },
                    ),
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

class BubbleSortSim extends StatefulWidget {
  final int numberOfElements;
  BubbleSortSim({
    Key key,
    @required this.numberOfElements,
  }) : super(key: key);
  @override
  _BubbleSortSimState createState() => _BubbleSortSimState();
}

class _BubbleSortSimState extends State<BubbleSortSim> {
  List<int> _elements = [];

  @override
  void initState() {
    super.initState();
    var rng = new Random();
    for (int i = 0; i < widget.numberOfElements; i++) {
      _elements.add(rng.nextInt(400));
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SchedulerBinding.instance.addPostFrameCallback((_) => bubbleSort());
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  bubbleSort() {
    var tmp;
    var swapped = false;
    do {
      swapped = false;
      for (var i = 1; i < _elements.length; i++) {
        if (_elements[i - 1] > _elements[i]) {
          tmp = _elements[i - 1];
          _elements[i - 1] = _elements[i];
          _elements[i] = tmp;
          swapped = true;
          sleep(const Duration(seconds:1));
          setState(() {});
        }
      }
    } while (swapped);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: BubbleSortPainter(
          _elements,
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        ),
        child: Container(),
      ),
    );
  }
}

class BubbleSortPainter extends CustomPainter {
  List<int> elements;
  double _barWidth;
  double height;
  BubbleSortPainter(this.elements, width, this.height) {
    _barWidth = (width / (elements.length + 1));
    print(_barWidth);
  }
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < elements.length; i++) {
      var paint = Paint();
      paint.color = Colors.white;
      paint.strokeWidth = _barWidth;
      canvas.drawLine(Offset((i + 1) * _barWidth, height),
          Offset((i + 1) * _barWidth, height - elements[i]), paint);
    }
  }

  @override
  bool shouldRepaint(BubbleSortPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BubbleSortPainter oldDelegate) => false;
}
