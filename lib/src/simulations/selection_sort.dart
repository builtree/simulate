import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectionSortBars extends StatefulWidget {
  @override
  _SelectionSortBarsState createState() => _SelectionSortBarsState();
}

class _SelectionSortBarsState extends State<SelectionSortBars> {
  int _numberOfElements;
  List<int> _elements = [];
  int i = 0, j = 1, counter = 0;
  int minIdx = 0;
  int n;
  int tmp, delay = 0, delay2 = 0;
  bool swap = false;
  double barwidth;
  List<Widget> containerList = [];
  bool doNotRefresh = false;
  int finalIterator = 0;
  final ScrollController _scrollController = ScrollController();

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
        if (k == minIdx) {
          containerList.add(Container(
            color: Colors.red,
            height: _elements[k] + 0.5,
            width: barwidth,
          ));
        } else if (k == i) {
          containerList.add(Container(
            color: Colors.blue,
            height: _elements[k] + 0.5,
            width: barwidth,
          ));
        } else {
          containerList.add(Container(
            color: Theme.of(context).primaryColor,
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
            color: Theme.of(context).primaryColor,
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

  nextStep() async {
    await Future.delayed(Duration(milliseconds: delay));
    if (!doNotRefresh) return;
    if (this.mounted) {
      setState(() {
        if (n == 1) {
          swap = false;
          return;
        }
        counter++;
        if (i == n - 1) {
          i = 0;
          n = 1;
          swap = false;
        }
        minIdx = i;
        for (j = i + 1; j < n; j++) {
          if (_elements[minIdx] > _elements[j]) {
            minIdx = j;
          }
        }

        tmp = _elements[i];
        _elements[i] = _elements[minIdx];
        _elements[minIdx] = tmp;
        i++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _containerList();
    if (swap == true || finalIterator != 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => nextStep());
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
        centerTitle: true,
        title: Text(
          'Selection Sort',
          style: Theme.of(context).textTheme.headline6,
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
        height: ScreenUtil().setHeight(1024 / 5.5),
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
                  min: 2,
                  max: 200,
                  activeColor: Theme.of(context).accentColor,
                  inactiveColor: Colors.grey,
                  onChanged: (value) {
                    doNotRefresh = false;
                    counter = 0;
                    swap = false;
                    finalIterator = 0;
                    setState(() {
                      _numberOfElements = value.toInt();
                    });
                  },
                  value: _numberOfElements.toDouble(),
                ),
                Center(
                  child: Text(
                    "Elements: ${_numberOfElements.toInt()}",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Slider(
                  min: 0,
                  max: 100,
                  divisions: 10,
                  activeColor: Theme.of(context).accentColor,
                  inactiveColor: Colors.grey,
                  onChanged: (value) {
                    setState(() {
                      delay2 = value.toInt();
                    });
                  },
                  onChangeEnd: (value) {
                    setState(() {
                      doNotRefresh = true;
                      delay = value.toInt();
                    });
                  },
                  value: delay2.roundToDouble(),
                ),
                Center(
                  child: Text(
                    "Delay: ${delay2.toInt()} ms",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ],
            ),
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
              "Swaps: $counter",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ],
      ),
    );
  }
}
