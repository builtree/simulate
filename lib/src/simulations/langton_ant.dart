import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final size = 29;
var colorsList =
    List<List<int>>.generate(size, (i) => List<int>.generate(size, (j) => 0));
enum direction { up, right, down, left }
direction headDir = direction.up;
var x = size ~/ 2, y = size ~/ 2;
var setupX = 0, setupY = 0;
int steps = 0;

class LangtonAnt extends StatefulWidget {
  _LangtonAntState createState() => _LangtonAntState();
}

class _LangtonAntState extends State<LangtonAnt> {
  _LangtonAntState() {
    colorsList[size ~/ 2][size ~/ 2] = 1;
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void nextPixel() {
    setState(() {
      ++steps;
      if (colorsList[x][y] == 0) {
        colorsList[x][y] = 1;
        if (headDir == direction.up) {
          if (x == 0)
            x = size - 1;
          else
            --x;
        } else if (headDir == direction.right) {
          if (y == 0)
            y = size - 1;
          else
            --y;
        } else if (headDir == direction.down) {
          if (x == size - 1)
            x = 0;
          else
            ++x;
        } else {
          if (y == size - 1)
            y = 0;
          else
            ++y;
        }
        headDir = direction.values[(direction.values.indexOf(headDir) - 1) % 4];
      } else {
        colorsList[x][y] = 0;
        if (headDir == direction.up) {
          if (x == size - 1)
            x = 0;
          else
            ++x;
        } else if (headDir == direction.right) {
          if (y == size - 1)
            y = 0;
          else
            ++y;
        } else if (headDir == direction.down) {
          if (x == 0)
            x = size - 1;
          else
            --x;
        } else {
          if (y == 0)
            y = size - 1;
          else
            --y;
        }
        headDir = direction.values[(direction.values.indexOf(headDir) + 1) % 4];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => nextPixel());
    setupX = 0;
    setupY = 0;
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
          "Langton's Ant",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Ubuntu',
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 2,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size,
                ),
                itemCount: size * size,
                itemBuilder: buildItem,
                padding: EdgeInsets.all(5.0),
              ),
            ),
          ),
          Positioned(
            child: Text(
              "Steps: $steps",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Ubuntu',
                fontSize: 18,
              ),
            ),
            top: 10,
            left: 10,
          ),
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    if (colorsList[setupX][setupY] == 1) {
      if (setupY == size - 1) {
        setupY = 0;
        ++setupX;
      } else
        ++setupY;
      return GridTile(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0.8),
            color: Colors.black,
          ),
        ),
      );
    } else {
      if (setupY == size - 1) {
        setupY = 0;
        ++setupX;
      } else
        ++setupY;
      return GridTile(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0.8),
            color: Colors.redAccent,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    colorsList = List<List<int>>.generate(
        size, (i) => List<int>.generate(size, (j) => 0));
    headDir = direction.up;
    x = size ~/ 2;
    y = size ~/ 2;
    steps = 0;
    super.dispose();
  }
}
