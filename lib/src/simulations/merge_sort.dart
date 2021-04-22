import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MergeSort extends StatefulWidget {
  @override
  _MergeSortState createState() => _MergeSortState();
}

class _MergeSortState extends State<MergeSort> {
  int _numberOfElements = 2;
  final ScrollController _scrollController = ScrollController();
  bool pause = true;
  int delay2 = 0;
  bool sort = false;
  List<int> elements = [];
  bool doNotRefresh = false;
  int n;
  double barwidth;
  StreamController<List<Container>> streamContainer = StreamController();
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

  addContainer(double barW, Color color, int l, int r) async {
    for (int i = l; i <= r; i++) {
      containers[i] = Container(
        color: color,
        height: elements[i] + 0.5,
        width: barW,
      );
    }
    await Future.delayed(Duration(milliseconds: delay2));
    streamContainer.add(containers);
  }

  _mergeSort(int leftIndex, int rightIndex) async {
    this.barwidth = MediaQuery.of(context).size.width / (elements.length + 1);

    Future<void> merge(int leftIndex, int middleIndex, int rightIndex) async {
      if (sort) {
        int leftSize = middleIndex - leftIndex + 1;
        int rightSize = rightIndex - middleIndex;

        List leftList = new List(leftSize);
        List rightList = new List(rightSize);

        for (int i = 0; i < leftSize; i++) leftList[i] = elements[leftIndex + i];
        for (int j = 0; j < rightSize; j++) rightList[j] = elements[middleIndex + j + 1];

        int i = 0, j = 0;
        int k = leftIndex;
        if (sort)
          while (i < leftSize && j < rightSize) {
            if (leftList[i] <= rightList[j]) {
              elements[k] = leftList[i];
              i++;
            } else {
              elements[k] = rightList[j];
              j++;
            }

            await addContainer(barwidth, Colors.blue, leftIndex, rightIndex);
            k++;
          }
        if (sort)
          while (i < leftSize) {
            elements[k] = leftList[i];
            i++;
            k++;

            await addContainer(barwidth, Colors.blue, leftIndex, rightIndex);
          }
        if (sort)
          while (j < rightSize) {
            elements[k] = rightList[j];
            j++;
            k++;

            await addContainer(barwidth, Colors.blue, leftIndex, rightIndex);
          }
      }
    }

    if (sort) if (leftIndex < rightIndex) {
      int middleIndex = (rightIndex + leftIndex) ~/ 2;
      if (sort) await _mergeSort(leftIndex, middleIndex);
      if (sort) await _mergeSort(middleIndex + 1, rightIndex);
      if (sort) await addContainer(barwidth, Colors.white, 0, _numberOfElements - 1);
      if (sort) await merge(leftIndex, middleIndex, rightIndex);
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
    await _mergeSort(0, elements.length - 1);
    setState(() {
      sort = false;
    });
    if (!pause) makeGreen();
  }

  _randomize() {
    elements = [];
    containers = [];
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
                  sort = false;
                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
              title: Text(
                'Merge Sort',
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
                pause = !pause;
                //TODO: Fix the bug, i.e, when we pause the code shows unusual behaviour
                if (!sort)
                  _sort();
                else
                  setState(() {
                    sort = false;
                  });
              },
            ),
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
                          List<Container> elements = snapshot.data;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: elements.map((e) {
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
