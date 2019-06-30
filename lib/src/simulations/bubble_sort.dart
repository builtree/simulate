import 'dart:io';
import 'dart:math';
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
  int i = 0;
  int n;
  int tmp;
  bool swap = true;
  double barwidth;
  List<Widget> containerList = [];

  @override
  void initState() {
    super.initState();
    var rng = new Random();
    for (int i = 0; i < widget.numberOfElements; i++) {
      _elements.add(rng.nextInt(400));
    }
    n = _elements.length;
  }

  @override
  dispose() {
    super.dispose();
  }

  List<Widget> returnContainers() {
    this.barwidth = MediaQuery.of(context).size.width / (_elements.length + 1);
    List<Widget> containers = [];
    for (int k = 0; k < _elements.length; ++k) {
      if (k == i) {
        containers.add(Container(
          color: Colors.red,
          height: _elements[k] + 0.0,
          width: barwidth,
        ));
      } else if (k == i - 1) {
        containers.add(Container(
          color: Colors.blue,
          height: _elements[k] + 0.0,
          width: barwidth,
        ));
      } else {
        containers.add(Container(
          color: Colors.white,
          height: _elements[k] + 0.0,
          width: barwidth,
        ));
      }
    }
    return containers;
  }

  nextStep() {
    if (n == 1) {
      swap = false;
    }
    if (i == n - 1) {
      i = 0;
      n--;
    }
    if (_elements[i] > _elements[i + 1]) {
      tmp = _elements[i];
      _elements[i] = _elements[i + 1];
      _elements[i + 1] = tmp;
      i++;
    } else {
      i++;
    }
    setState(() {
      sleep(const Duration(seconds: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    containerList = returnContainers();
    if (swap == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) => nextStep());
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: containerList,
    );
  }
}
