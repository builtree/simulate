import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PigeonholeSort extends StatefulWidget {
  @override
  _PigeonholeSortState createState() => _PigeonholeSortState();
}

class _PigeonholeSortState extends State<PigeonholeSort> {
  int _numberOfElements = 2;
  final ScrollController _scrollController = ScrollController();
  int delay2 = 0;
  bool sort = false;
  // List<Widget> containerList = [];
  // bool pauseSort = false;
  List<int> elements = [];
  bool doNotRefresh = false;
  int n;
  double barwidth;
  StreamController<List<int>> streamController = StreamController();

  @override
  void initState() {
    _numberOfElements = 2;
    doNotRefresh = false;
    _randomize();
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
    streamController.close();
    super.dispose();
  }

  _pigeonSort() async {
    if (sort) {
      int min = elements[0];
      int max = elements[0];
      int range, i, index, j;
      for (int a = 0; a < elements.length; a++) {
        if (sort) {
          if (elements[a] > max) max = elements[a];
          if (elements[a] < min) min = elements[a];
        }
      }
      range = max - min + 1;
      List<int> pHole = List.generate(range, (i) => 0);
      for (i = 0; i < elements.length; i++) {
        pHole[elements[i] - min]++;
      }
      index = 0;
      for (j = 0; j < range; j++) {
        if (sort) {
          while (pHole[j]-- > 0) {
            if (sort) {
              elements[index++] = j + min;
              await Future.delayed(Duration(milliseconds: delay2));
              streamController.add(elements);
            }
          }
        }
      }
    }
  }

  _sort() async {
    setState(() {
      sort = true;
    });
    await _pigeonSort();
    setState(() {
      sort = false;
    });
  }

  _randomize() {
    elements = [];
    for (int i = 0; i < _numberOfElements; i++) {
      elements.add(Random().nextInt(400));
    }
    sort = false;
    streamController.add(elements);
  }

  @override
  Widget build(BuildContext context) {
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
                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
              title: Text(
                'Pigeonhole Sort',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              child: (!sort)
                  ? Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                    )
                  : Icon(
                      Icons.pause,
                      color: Colors.black,
                    ),
              onPressed: () {
                //TODO: Fix the bug, i.e, when we pause the code shows unusual behaviour
                if (!sort)
                  _sort();
                else
                  sort = false;
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
                        value: _numberOfElements.toDouble(),
                        onChanged: (value) {
                          doNotRefresh = false;
                          sort = false;
                          setState(() {
                            _numberOfElements = value.toInt();
                            _randomize();
                          });
                        },
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
                            delay2 = value.toInt();
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
              children: [
                Container(
                  color: Colors.grey[900],
                  child: Column(
                    children: [
                      Spacer(),
                      StreamBuilder<Object>(
                        initialData: elements,
                        stream: streamController.stream,
                        builder: (context, snapshot) {
                          List<int> numbers = snapshot.data;
                          this.barwidth = MediaQuery.of(context).size.width /
                              (elements.length + 1);
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: numbers.map((e) {
                              return Container(
                                color: Theme.of(context).primaryColor,
                                height: e + 0.5,
                                width: barwidth,
                              );
                            }).toList(),
                          );
                        },
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                // Positioned(
                //   top: 5,
                //   left: 5,
                //   child: Text(
                //     "Comparisons: $counter \nMax: ${_elements[i]} \nArray Iteration: ${_elements.length - n + 1}",
                //     style: Theme.of(context).textTheme.subtitle2,
                //   ),
                // ),
              ],
            ),
          );
        }
      },
    );
  }
}
