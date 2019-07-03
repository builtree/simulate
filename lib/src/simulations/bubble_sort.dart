import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BubbleSortBars extends StatefulWidget {
  @override
  _BubbleSortBarsState createState() => _BubbleSortBarsState();
}

class _BubbleSortBarsState extends State<BubbleSortBars> {
  int _numberOfElements;
  List<int> _elements = [];
  int i = 0, counter = 0;
  int n;
  int tmp, delay = 0;
  bool swap = false;
  double barwidth;
  List<Widget> containerList = [];
  bool doNotRefresh = false;
  int finalIterator = 0;

  @override
  void initState() {
    _numberOfElements = 2;
    i = 0;
    counter = 0;
    swap = false;
    doNotRefresh = false;
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

  _containerList() {
    containerList.clear();
    if (!doNotRefresh) {
      _elements.clear();
      i = 0;
      var rng = new Random();
      for (int i = 0; i < _numberOfElements; i++) {
        _elements.add(rng.nextInt(400));
      }
      n = _elements.length;
    }
    this.barwidth = MediaQuery.of(context).size.width / (_elements.length + 1);
    if (n != 1) {
      for (int k = 0; k < _elements.length; ++k) {
        if (k == i) {
          containerList.add(Container(
            color: Colors.red,
            height: _elements[k] + 0.5,
            width: barwidth,
          ));
        } else if (k == i - 1) {
          containerList.add(Container(
            color: Colors.blue,
            height: _elements[k] + 0.5,
            width: barwidth,
          ));
        } else {
          containerList.add(Container(
            color: Colors.white,
            height: _elements[k] + 0.5,
            width: barwidth,
          ));
        }
      }
    } else {
      containerList.clear();
      finalIterator++;

      for (int k = 0; k < _elements.length; ++k) {
        if (k <= finalIterator) {
          containerList.add(Container(
            color: Colors.greenAccent[400],
            height: _elements[k] + 0.5,
            width: barwidth,
          ));
        } else {
          containerList.add(Container(
            color: Colors.white,
            height: _elements[k] + 0.5,
            width: barwidth,
          ));
        }
      }
      if (finalIterator == _elements.length) {
        finalIterator = 0;
      }
    }
  }

  nextStep() {
    setState(() {
      sleep(Duration(milliseconds: delay));
      if (n == 1) {
        swap = false;
        return;
      }
      counter++;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    _containerList();
    if (swap == true || finalIterator != 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => nextStep());
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Bubble Sort',
          style: TextStyle(
            fontFamily: 'Ubuntu',
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: (!swap)
              ? Icon(
                  Icons.play_arrow,
                  color: Colors.black,
                )
              : Icon(
                  Icons.pause,
                  color: Colors.black,
                ),
          onPressed: () {
            doNotRefresh = true;
            swap = !swap;
            setState(() {});
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height / 6,
        child: Material(
          elevation: 30,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Spacer(flex: 2),
              Slider(
                min: 2,
                max: 200,
                activeColor: Colors.black,
                inactiveColor: Colors.grey,
                onChanged: (value) {
                  doNotRefresh = false;
                  counter = 0;
                  swap = false;
                  setState(() {
                    _numberOfElements = value.toInt();
                  });
                },
                value: _numberOfElements.toDouble(),
              ),
              Center(
                child: Text(
                  "Elements: ${_numberOfElements.toInt()}",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Slider(
                min: 0,
                max: 500,
                activeColor: Colors.black,
                inactiveColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    doNotRefresh = true;
                    delay = value.toInt();
                  });
                },
                value: delay.roundToDouble(),
              ),
              Center(
                child: Text(
                  "Delay: ${delay.toInt()} ms",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.grey[900],
            child: Column(
              children: <Widget>[
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: containerList,
                ),
                Spacer(),
              ],
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: Text(
              "Counter: $counter",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Ubuntu',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
