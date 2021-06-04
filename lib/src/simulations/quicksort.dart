import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickSort extends StatefulWidget {
  @override
  _QuickSortState createState() => _QuickSortState();
}

class _QuickSortState extends State<QuickSort> {
  int _numberOfElements = 2;
  final ScrollController _scrollController = ScrollController();
  int delay = 0;
  bool sorting = false;
  List<int> elements = [];
  int top = -1;
  int l = 0, h = 1;
  int i = -1, j = 0;
  int looping = 0;
  double barwidth = 1;
  List<Container> containerList = [];
  List<int> stack = new List(2);

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _randomize();
      });
    });
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

  _randomize() {
    elements = [];
    containerList = [];
    for (int k = 0; k < _numberOfElements; k++)
      elements.add(Random().nextInt(400));
    containerList = elements
        .map((e) => Container(
              color: Theme.of(context).primaryColor,
              height: e + 0.5,
              width: MediaQuery.of(context).size.width / (elements.length + 1),
            ))
        .toList();
    sorting = false;
    l = 0;
    h = _numberOfElements - 1;
    top = -1;
    i = -1;
    j = 0;
    looping = 0;
    stack = new List(_numberOfElements);
    stack[++top] = l;
    stack[++top] = h;
    barwidth = MediaQuery.of(context).size.width / (elements.length + 1);
  }

  nextStep() async {
    await Future.delayed(Duration(milliseconds: delay));
    if (looping == 0) {
      h = stack[top--];
      l = stack[top--];
      i = (l - 1);
      j = l;
      looping = 1;
    }
    if (looping == 1) {
      if (j < h) {
        if (elements[j] <= elements[h]) {
          i++;
          int temp = elements[i];
          elements[i] = elements[j];
          elements[j] = temp;
          containerList = elements
              .map((e) => Container(
                    color: Theme.of(context).primaryColor,
                    height: e + 0.5,
                    width: barwidth,
                  ))
              .toList();
        }
        j++;
      } else if (j >= h) looping = 2;
    } else if (looping == 2) {
      int temp = elements[i + 1];
      elements[i + 1] = elements[h];
      elements[h] = temp;
      containerList = elements
          .map((e) => Container(
                color: Theme.of(context).primaryColor,
                height: e + 0.5,
                width: barwidth,
              ))
          .toList();
      int p = i + 1;
      if (p - 1 > l) {
        stack[++top] = l;
        stack[++top] = p - 1;
      }
      if (p + 1 < h) {
        stack[++top] = p + 1;
        stack[++top] = h;
      }
      looping = 3;
    }
    setState(() {
      if (looping == 3) {
        if (top != -1)
          looping = 0;
        else
          sorting = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (sorting == true && looping != 3) {
      WidgetsBinding.instance.addPostFrameCallback((_) => nextStep());
    }

    return LayoutBuilder(
      // ignore: missing_return
      builder: (_, BoxConstraints constraints) {
        if (constraints.maxWidth != 0) {
          ScreenUtil.init(
            constraints,
            designSize: Size(512.0, 1024.0),
            allowFontScaling: true,
          );
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  sorting = false;
                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
              title: Text(
                'Quick Sort',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              child: (!sorting)
                  ? Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                    )
                  : Icon(
                      Icons.pause,
                      color: Colors.black,
                    ),
              onPressed: () {
                if (!sorting) {
                  setState(() {
                    sorting = true;
                  });
                } else
                  setState(() {
                    sorting = false;
                  });
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
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
                          sorting = false;
                          setState(() {
                            _numberOfElements = value.toInt();
                            _randomize();
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
                            delay = value.toInt();
                          });
                        },
                        onChangeEnd: (value) {
                          setState(() {
                            delay = value.toInt();
                          });
                        },
                        value: delay.roundToDouble(),
                      ),
                      Center(
                        child: Text(
                          "Delay: ${delay.toInt()} ms",
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
                    "Swap: \nPivot:  ",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
