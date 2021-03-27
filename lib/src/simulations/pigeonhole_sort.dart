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
  List<int> elements = [];
  bool doNotRefresh = false;
  int n;
  double barwidth;
  StreamController<List<Container>> streamContainer = StreamController();
  List<int> pHole = [];
  List<Container> containers = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _numberOfElements = 2;
      doNotRefresh = false;
      _randomize();
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
    streamContainer.close();
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
      pHole = List.generate(range, (i) => 0);
      for (i = 0; i < elements.length; i++) {
        pHole[elements[i] - min]++;
      }
      index = 0;
      for (j = 0; j < range; j++) {
        if (sort) {
          while (pHole[j]-- > 0) {
            if (sort) {
              elements[index++] = j + min;
              this.barwidth =
                  MediaQuery.of(context).size.width / (elements.length + 1);
              for (int zz = 0; zz < _numberOfElements; zz++) {
                if (zz == index) {
                  containers[zz] = Container(
                    color: Colors.blue,
                    height: (elements[zz] + 0.5),
                    width: barwidth,
                  );
                } else {
                  containers[zz] = Container(
                    color: Colors.white,
                    height: (elements[zz] + 0.5),
                    width: barwidth,
                  );
                }
              }
              await Future.delayed(Duration(milliseconds: delay2));

              streamContainer.add(containers);
            }
          }
        }
      }
    }
  }

  makeGreen() async {
    for (var i = 0; i < _numberOfElements; i++) {
      await Future.delayed(Duration(milliseconds: delay2));

      containers[i] = Container(
        color: Colors.greenAccent[400],
        height: (elements[i] + 0.5),
        width: barwidth,
      );
      streamContainer.add(containers);
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
    makeGreen();
  }

  _randomize() {
    elements = [];
    containers = [];
    pHole = [];
    for (int i = 0; i < _numberOfElements; i++) {
      elements.add(Random().nextInt(400));
    }
    for (int i = 0; i < _numberOfElements; i++) {
      containers.add(Container(
        color: Colors.white,
        height: (elements[i] + 0.5),
        width: MediaQuery.of(context).size.width / (elements.length + 1),
      ));
    }

    sort = false;
    streamContainer.add(containers);
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
            backgroundColor: Colors.white,
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
                        initialData: containers,
                        stream: streamContainer.stream,
                        builder: (context, snapshot) {
                          List<Container> numbers = snapshot.data;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: numbers.map((e) {
                              return e;
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
