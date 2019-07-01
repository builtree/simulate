import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BubbleSortBars extends StatefulWidget {
  @override
  _BubbleSortBarsState createState() => _BubbleSortBarsState();
}

class _BubbleSortBarsState extends State<BubbleSortBars> {
  int _numberOfElements = 2;
  List<int> _elements = [];
  int i = 0, counter = 0;
  int n;
  int tmp;
  bool swap = false;
  double barwidth;
  List<Widget> containerList = [];
  bool doNotRefresh = false;

  @override
  void initState() {
    _numberOfElements = 2;
    i = 0;
    counter = 0;
    swap = false;
    doNotRefresh = false;
    super.initState();
  }

  @override
  dispose() {
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
    for (int k = 0; k < _elements.length; ++k) {
      if (k == i) {
        containerList.add(Container(
          color: (swap) ? Colors.red : Colors.white,
          height: _elements[k] + 0.5,
          width: barwidth,
        ));
      } else if (k == i - 1) {
        containerList.add(Container(
          color: (swap) ? Colors.blue : Colors.white,
          height: _elements[k] + 0.5,
          width: barwidth,
        ));
      } else {
        containerList.add(Container(
          color: Colors.white,
          height: _elements[k] + 0.5,
          width: barwidth,
        ));
      }
    }
  }

  nextStep() {
    counter++;
    setState(() {
      if (n == 1) {
        swap = false;
      }
      if (i == n - 1) {
        i = 0;
        n--;
      }
      if (_elements[i] > _elements[i + 1]) {
        tmp = _elements[i];
        _elements[i] = _elements[i + 1];
        _elements[i + 1] = tmp;
        i++;
      } else {
        i++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _containerList();
    if (swap == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) => nextStep());
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Bubble Sort',
          style: TextStyle(fontFamily: 'Ubuntu'),
        ),
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          child: (!swap) ? Icon(Icons.play_arrow) : Icon(Icons.pause),
          onPressed: () {
            doNotRefresh = true;
            swap = !swap;
            setState(() {});
            // doNotRefresh = false;
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height / 8,
        child: Material(
          elevation: 30,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Spacer(flex: 2),
              Slider(
                min: 2,
                max: 99,
                onChanged: (value) {
                  doNotRefresh = false;
                  counter = 0;
                  swap = false;
                  setState(() {
                    _numberOfElements = value.toInt();
                  });
                },
                value: _numberOfElements.toDouble(),
              ),
              Center(
                child: Text(
                  "${_numberOfElements.toInt()}",
                  style: TextStyle(
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
              "Counter: $counter",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Ubuntu',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class BubbleSortSim extends StatefulWidget {
//   final int numberOfElements;
//   BubbleSortSim({
//     Key key,
//     @required this.numberOfElements,
//   }) : super(key: key);
//   @override
//   _BubbleSortSimState createState() => _BubbleSortSimState();
// }

// class _BubbleSortSimState extends State<BubbleSortSim> {
//   List<int> _elements = [];
//   int i = 0;
//   int n;
//   int tmp;
//   bool swap = true;
//   double barwidth;
//   List<Widget> containerList = [];

//   @override
//   void initState() {
//     super.initState();
//     var rng = new Random();
//     for (int i = 0; i < widget.numberOfElements; i++) {
//       _elements.add(rng.nextInt(400));
//     }
//     n = _elements.length;
//   }

//   @override
//   dispose() {
//     super.dispose();
//   }

//   List<Widget> returncontainerList() {
//     this.barwidth = MediaQuery.of(context).size.width / (_elements.length + 1);
//     List<Widget> containerList = [];
//     for (int k = 0; k < _elements.length; ++k) {
//       if (k == i) {
//         containerList.add(Container(
//           color: Colors.red,
//           height: _elements[k] + 0.0,
//           width: barwidth,
//         ));
//       } else if (k == i - 1) {
//         containerList.add(Container(
//           color: Colors.blue,
//           height: _elements[k] + 0.0,
//           width: barwidth,
//         ));
//       } else {
//         containerList.add(Container(
//           color: Colors.white,
//           height: _elements[k] + 0.0,
//           width: barwidth,
//         ));
//       }
//     }
//     return containerList;
//   }

//   nextStep() {
//     if (n == 1) {
//       swap = false;
//     }
//     if (i == n - 1) {
//       i = 0;
//       n--;
//     }
//     if (_elements[i] > _elements[i + 1]) {
//       tmp = _elements[i];
//       _elements[i] = _elements[i + 1];
//       _elements[i + 1] = tmp;
//       i++;
//     } else {
//       i++;
//     }
//     setState(() {
//       sleep(const Duration(seconds: 1));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     containerList = returncontainerList();
//     // if (swap == true) {
//     //   WidgetsBinding.instance.addPostFrameCallback((_) => nextStep());
//     // }
//     return Stack(
//       children: <Widget>[
//         Container(
//           color: Colors.grey[900],
//           child: Column(
//             children: <Widget>[
//               Spacer(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: containerList,
//               ),
//               Spacer(),
//             ],
//           ),
//         ),
//         Positioned(
//           top: 5,
//           left: 5,
//           child: Text(
//             "Counter: ",
//             style: TextStyle(
//               color: Colors.white,
//               fontFamily: 'Ubuntu',
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
