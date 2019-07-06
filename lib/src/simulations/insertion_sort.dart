import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  _InsertionHomeState createState() => _InsertionHomeState();
}

class _InsertionHomeState extends State<InsertionHome> {
  var randomVar = Random();
  List<int> barValuesList = [];
  List<Container> barsList = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  makeContainers() {
    if (!doNotRefresh || barValuesList.length == 0) {
      barValuesList = List.generate(
          sliderValue.toInt(),
          (idx) =>
              randomVar.nextInt(MediaQuery.of(context).size.height ~/ 1.7));
    } else
      doNotRefresh = false;
    int temp = 0;
    barsList.clear();
    greenIterator = 0;
    barValuesList.forEach((value) {
      barsList.add(
        Container(
          width: MediaQuery.of(context).size.width / sliderValue * 0.9,
          height: (value != 0) ? value.toDouble() : 0.5,
          color: (temp == iterator)
              ? Colors.red
              : (temp != i)
                  ? Colors.white
                  : (i != barValuesList.length - 1)
                      ? Colors.blue
                      : Colors.white,
        ),
      );
      ++temp;
    });
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

  sortBars() {
    setState(() {
      if (!isWorking) return;
      colorGreen = false;
      sleep(Duration(milliseconds: sleepDuration));
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
    if (!colorGreen)
      makeContainers();
    else
      makeGreen();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          doNotRefresh = true;
        }));
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 5,
        centerTitle: true,
        title: Text(
          "Insertion Sort",
          style: TextStyle(
            fontFamily: 'Ubuntu',
            color: Colors.black,
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
                  children: barsList,
                ),
                Spacer(),
              ],
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: Text(
              "Counter: $numSteps",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Ubuntu',
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height / 5.5,
        child: Material(
          elevation: 30,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Spacer(flex: 5),
              Slider(
                min: 2,
                max: 149,
                activeColor: Colors.black,
                inactiveColor: Colors.black38,
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
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              Spacer(),
              Slider(
                min: 0,
                max: 500,
                activeColor: Colors.black,
                inactiveColor: Colors.black38,
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
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              Spacer(flex: 3),
            ],
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
            ? Icon(
                Icons.play_arrow,
                size: 30,
                color: Colors.black,
              )
            : Icon(
                Icons.pause,
                size: 30,
                color: Colors.black,
              ),
        backgroundColor: Colors.white,
        elevation: 8,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
