import 'dart:math';

import 'package:flutter/material.dart';

int sliderValue = 5;
bool isWorking = false, doNotRefresh = false;

class InsertionHome extends StatefulWidget {
  _InsertionHomeState createState() => _InsertionHomeState();
}

class _InsertionHomeState extends State<InsertionHome> {
  var randomVar = Random();
  List<int> barValuesList;
  List<Container> barsList = [];

  makeContainers() {
    if (!doNotRefresh || barValuesList.length == 0) {
      barValuesList = List.generate(
          sliderValue.toInt(),
          (idx) =>
              randomVar.nextInt(MediaQuery.of(context).size.height ~/ 1.5));
    } else
      doNotRefresh = false;
    barsList.clear();
    barValuesList.forEach((value) => barsList.add(
          Container(
            width: MediaQuery.of(context).size.width / sliderValue * 0.9,
            height: (value != 0) ? value.toDouble() : 0.5,
            color: Colors.white,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    makeContainers();
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
      body: Container(
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
      bottomNavigationBar: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height / 8,
        child: Material(
          elevation: 30,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Spacer(flex: 2),
              Slider(
                min: 5,
                max: 50,
                activeColor: Colors.orange,
                inactiveColor: Colors.orange[50],
                onChanged: (value) {
                  setState(() {
                    isWorking = false;
                    sliderValue = value.toInt();
                  });
                },
                value: sliderValue.toDouble(),
              ),
              Center(
                child: Text(
                  "${sliderValue.toInt()}",
                  style: TextStyle(
                    color: Colors.orangeAccent[400],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            doNotRefresh = true;
            isWorking = !isWorking;
          });
        },
        child: (!isWorking)
            ? Icon(
                Icons.play_arrow,
                size: 30,
              )
            : Icon(
                Icons.stop,
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
    sliderValue = 5;
    super.dispose();
  }
}
