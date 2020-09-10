import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BubbleSortBars extends StatefulWidget {
  @override
  _BubbleSortBarsState createState() => _BubbleSortBarsState();
}

class _BubbleSortBarsState extends State<BubbleSortBars> {
  int _numberOfElements = 5;
  List<int> _elements = [];
  int i = 0, counter = 0;
  int n = 5;
  int delay = 1000;
  bool animating = false;
  bool sorted = false;
  double barwidth = 0;
  bool refresh = true, resetIndex = true;
  List<dynamic> barColor = [];
  List<int> _index = [];

  @override
  void initState() {
    _numberOfElements = 5;
    i = 0;
    counter = 0;
    animating = false;
    refresh = true;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  dispose() {
    animating = false;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  _initialize() {
    if (refresh) {
      barColor.clear();
      _elements.clear();
      _index.clear();
      i = 0;
      var rng = new Random();
      for (int i = 0; i < _numberOfElements; i++) {
        _elements.add(rng.nextInt(400));
        _index.add(i);
        barColor.add(Theme.of(context).primaryColor);
      }
      n = _elements.length;
    }
    this.barwidth = MediaQuery.of(context).size.width / (_elements.length + 1);
  }

  nextStep() async {
    await Future.delayed(Duration(milliseconds: 3 * delay));
    if (this.mounted) {
      setState(() {
        barColor.clear();
        for (int j = 0; j < _elements.length; j++) {
          if (n == 1)
            barColor.add(Colors.greenAccent[400]);
          else
            barColor.add(Theme.of(context).primaryColor);
          if (resetIndex) _index[j] = j;
        }
        if (n == 1) {
          animating = false;
          return;
        }
        counter++;
        if (i == n - 1) {
          i = 0;
          n--;
        }
        barColor[i] = Colors.blue;
        if (_elements[i] > _elements[i + 1]) {
          if (resetIndex) {
            resetIndex = false;
          } else {
            barColor[i] = Colors.red;
            barColor[i + 1] = Colors.red;
            final temp = _index[i];
            _index[i] = _index[i + 1];
            _index[i + 1] = temp;
            final tmp = _elements[i];
            _elements[i] = _elements[i + 1];
            _elements[i + 1] = tmp;
            i++;
            resetIndex = true;
          }
        } else {
          i++;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 720.0,
      height: 1600.0,
      allowFontScaling: true,
    );
    _initialize();
    if (animating) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        nextStep();
      });
    }
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
          'Bubble Sort',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
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
                    refresh = false;
                    animating = !animating;
                  });
                }),
            FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.highlight_off,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  counter = 0;
                  i = 0;
                  refresh = true;
                  animating = false;
                  _initialize();
                });
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: ScreenUtil().setHeight(1600 / 4.0),
        child: Material(
          elevation: 30,
          color: Theme.of(context).primaryColor,
          child: ListView(
            padding: EdgeInsets.all(8.0),
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Slider(
                min: 5,
                max: 100,
                activeColor: Theme.of(context).accentColor,
                inactiveColor: Colors.grey,
                onChanged: (animating)
                    ? null
                    : (value) {
                        refresh = true;
                        counter = 0;
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
              Slider(
                min: 0,
                max: 2000,
                divisions: 8,
                activeColor: Theme.of(context).accentColor,
                inactiveColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    delay = value.toInt();
                  });
                },
                value: delay.roundToDouble(),
              ),
              Center(
                child: Text(
                  "Delay: ${delay / 1000.toInt()} s",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.grey[900],
            child: Stack(
              children: <Widget>[
                for (var k = 0; k < _elements.length; k++)
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 2 * delay),
                    left: _index[k] * barwidth +
                        ((_index[k] + 1) * barwidth / (_numberOfElements + 1)),
                    curve: Curves.elasticOut,
                    child: Container(
                      color: barColor[k],
                      height: _elements[_index[k]] + 0.5,
                      width: barwidth,
                    ),
                  ),
              ],
              alignment: AlignmentDirectional.center,
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: Text(
              "Comparisons: $counter \nMax: ${_elements[i]} \nArray Iteration: ${_elements.length - n + 1}",
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
