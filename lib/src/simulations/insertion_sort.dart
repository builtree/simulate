import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

int sliderValue = 2,
    iterator = -1,
    i = -1,
    numSteps = 0,
    sleepDuration = 70,
    greenIterator = 0;
bool isWorking = false,
    doNotRefresh = true,
    colorGreen = false,
    wasAlreadyWorking = false;

class InsertionHome extends StatefulWidget {
  const InsertionHome({Key key}) : super(key: key);

  @override
  _InsertionHomeState createState() => _InsertionHomeState();
}

class _InsertionHomeState extends State<InsertionHome> {
  var randomVar = Random();
  List<int> barValuesList = [];
  List<Container> barsList = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  makeContainers() {
    if (!doNotRefresh || barValuesList.isEmpty) {
      barValuesList = List.generate(
          sliderValue.toInt(),
          (idx) =>
              randomVar.nextInt(MediaQuery.of(context).size.height ~/ 1.7));
    } else {
      doNotRefresh = false;
    }
    int temp = 0;
    barsList.clear();
    greenIterator = 0;
    for (var value in barValuesList) {
      barsList.add(
        Container(
          width: MediaQuery.of(context).size.width / sliderValue * 0.9,
          height: (value != 0) ? value.toDouble() : 0.5,
          color: (temp == iterator)
              ? Colors.red
              : (temp != i)
                  ? Theme.of(context).primaryColor
                  : (i != barValuesList.length - 1)
                      ? Colors.blue
                      : Theme.of(context).primaryColor,
        ),
      );
      ++temp;
    }
    sortBars();
  }

  makeGreen() {
    setState(() {
      if (greenIterator < sliderValue) {
        int value = barValuesList[greenIterator];
        barsList.removeAt(greenIterator);
        barsList.insert(
          greenIterator,
          Container(
            width: MediaQuery.of(context).size.width / sliderValue * 0.9,
            height: (value != 0) ? value.toDouble() : 0.5,
            color: Colors.greenAccent[400],
          ),
        );
      }
      ++greenIterator;
    });
  }

  sortBars() async {
    await Future.delayed(Duration(milliseconds: sleepDuration));
    setState(() {
      if (!isWorking) return;
      colorGreen = false;
      if (iterator < barValuesList.length) {
        for (i = 0; i < iterator; i++) {
          ++numSteps;
          if (barValuesList[i] > barValuesList[iterator]) {
            int temp = barValuesList[iterator];
            barValuesList.removeAt(iterator);
            barValuesList.insert(i, temp);
            break;
          }
        }
        ++iterator;
      } else if (iterator == barValuesList.length) {
        i = barValuesList.length - 1;
        ++iterator;
      } else {
        colorGreen = true;
        isWorking = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!colorGreen) {
      makeContainers();
    } else {
      makeGreen();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          doNotRefresh = true;
        }));
    return LayoutBuilder(
      // ignore: missing_return
      builder: (_, BoxConstraints constraints) {
        if (constraints.maxWidth != 0) {
          ScreenUtil.init(
            constraints,
            designSize: const Size(512.0, 1024.0),
            allowFontScaling: true,
          );
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
              elevation: 5,
              centerTitle: true,
              title: Text(
                "Insertion Sort",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            body: Stack(
              children: <Widget>[
                Container(
                  color: Colors.grey[900],
                  child: Column(
                    children: <Widget>[
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: barsList,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 5,
                  child: Text(
                    "Counter: $numSteps",
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              color: Colors.transparent,
              height: ScreenUtil().setHeight(1024 / 5.5),
              child: Material(
                elevation: 30,
                color: Theme.of(context).primaryColor,
                child: Scrollbar(
                  controller: _scrollController,
                  isAlwaysShown: true,
                  child: ListView(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Slider(
                        min: 2,
                        max: 149,
                        activeColor: Theme.of(context).colorScheme.secondary,
                        inactiveColor: Colors.grey,
                        onChanged: (value) {
                          setState(() {
                            colorGreen = false;
                            isWorking = false;
                            doNotRefresh = false;
                            sliderValue = value.toInt();
                            iterator = -1;
                            i = -1;
                            numSteps = 0;
                          });
                        },
                        value: sliderValue.toDouble(),
                      ),
                      Center(
                        child: Text(
                          "Elements: $sliderValue",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                      Slider(
                        min: 0,
                        max: 500,
                        activeColor: Theme.of(context).colorScheme.secondary,
                        inactiveColor: Colors.grey,
                        onChangeStart: (value) {
                          setState(() {
                            if (isWorking) wasAlreadyWorking = true;
                            doNotRefresh = true;
                            isWorking = false;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            doNotRefresh = true;
                            sleepDuration = value.toInt();
                          });
                        },
                        onChangeEnd: (value) {
                          setState(() {
                            doNotRefresh = true;
                            if (wasAlreadyWorking) {
                              isWorking = true;
                              wasAlreadyWorking = false;
                            }
                            sleepDuration = value.toInt();
                          });
                        },
                        value: sleepDuration.toDouble(),
                      ),
                      Center(
                        child: Text(
                          "Delay (milliseconds): $sleepDuration",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  doNotRefresh = true;
                  isWorking = !isWorking;
                  (iterator == -1) ? iterator = 1 : iterator = iterator;
                });
              },
              child: (!isWorking || colorGreen)
                  ? const Icon(
                      Icons.play_arrow,
                      size: 30,
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.pause,
                      size: 30,
                      color: Colors.black,
                    ),
              backgroundColor: Colors.white,
              elevation: 8,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    sliderValue = 2;
    iterator = -1;
    i = -1;
    numSteps = 0;
    isWorking = false;
    doNotRefresh = true;
    sleepDuration = 70;
    greenIterator = 0;
    colorGreen = false;
    wasAlreadyWorking = false;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }
}
