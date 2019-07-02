import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

int sliderValue = 2, iterator = -1, i = -1, numSteps = 0, sleepDuration = 70;
bool isWorking = false, doNotRefresh = true;

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
    barsList.clear();
    int temp = 0;
    barValuesList.forEach((value) {
      barsList.add(
        Container(
          width: MediaQuery.of(context).size.width / sliderValue * 0.9,
          height: (value != 0) ? value.toDouble() : 0.5,
          color: (temp == iterator)
              ? Colors.blue
              : (temp != i)
                  ? Colors.white
                  : (i != barValuesList.length - 1) ? Colors.red : Colors.white,
        ),
      );
      ++temp;
    });
    sortBars();
  }

  sortBars() {
    setState(() {
      if (!isWorking) return;
      sleep(Duration(milliseconds: sleepDuration));
      if (iterator != barValuesList.length) {
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
      } else {
        isWorking = false;
        i = barValuesList.length - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    makeContainers();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          doNotRefresh = true;
        }));
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          iconSize: 28,
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
            fontSize: 28,
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
        height: MediaQuery.of(context).size.height / 5,
        child: Material(
          elevation: 30,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Spacer(flex: 4),
              Slider(
                min: 2,
                max: 99,
                activeColor: Colors.orange,
                inactiveColor: Colors.orange[50],
                onChanged: (value) {
                  setState(() {
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
                    color: Colors.orangeAccent[400],
                    fontSize: 18,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              Slider(
                min: 0,
                max: 200,
                activeColor: Colors.orange,
                inactiveColor: Colors.orange[50],
                onChanged: (value) {
                  doNotRefresh = true;
                  sleepDuration = value.toInt();
                },
                value: sleepDuration.toDouble(),
              ),
              Center(
                child: Text(
                  "Delay (milliseconds): $sleepDuration",
                  style: TextStyle(
                    color: Colors.orangeAccent[400],
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
        child: (!isWorking)
            ? Icon(
                Icons.play_arrow,
                size: 30,
              )
            : Icon(
                Icons.pause,
                size: 30,
              ),
        backgroundColor: Colors.orange,
        elevation: 5,
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
    super.dispose();
  }
}
