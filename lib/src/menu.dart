import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'simulations/toothpick.dart';
import 'simulations/counting.dart';
import 'simulations/counter.dart';
import 'simulations/langton_ant.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.grey[200],
      home: SimulationsList(),
      theme: ThemeData(fontFamily: 'Raleway'),
    );
  }
}

class SimulationsList extends StatefulWidget {
  _SimulationsListState createState() => _SimulationsListState();
}

class _SimulationsListState extends State<SimulationsList>
    with SingleTickerProviderStateMixin {
  final List<Tab> simTabs = [
    Tab(text: "Langton"),
    Tab(text: "Toothpick"),
    Tab(text: "Counting"),
    Tab(text: "Count_N"),
  ];
  var isPressed = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: simTabs.length,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(240),
          child: Stack(
            children: <Widget>[
              AppBar(
                elevation: 0,
                backgroundColor: Colors.grey[200],
                bottom: TabBar(
                  labelPadding: EdgeInsets.all(15),
                  isScrollable: true,
                  labelColor: Colors.grey[600],
                  labelStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                  ),
                  tabs: simTabs,
                  indicatorColor: Colors.transparent,
                ),
              ),
              Positioned(
                left: 20,
                top: 120,
                child: Text(
                  "GENERAL",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontSize: 60,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 5,
              left: 15,
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                shadowColor: Colors.grey[200],
                elevation: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 740,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            TabBarView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Positioned(
                      top: 500,
                      left: 50,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => LangtonAnt()),
                          );
                        },
                        child: Material(
                          elevation: 10,
                          shadowColor: Colors.deepOrangeAccent[400],
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.deepOrange,
                          child: Container(
                            width: 240,
                            height: 75,
                            color: Colors.transparent,
                            child: Center(
                              child: Text(
                                "START",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    (isPressed)
                        ? Positioned(
                            top: 20,
                            left: 100,
                            child: Image.asset('assets/gifs/langton_ant.gif'),
                          )
                        : Positioned(
                            top: 110,
                            left: 60,
                            child: Text(
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 30,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                    (isPressed)
                        ? Positioned(
                            top: 320,
                            left: 80,
                            child: Text(
                              "Lorem Ipsum Dolor\nSit Amet",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 30,
                              ),
                            ),
                          )
                        : Positioned(
                            top: 250,
                            left: 60,
                            child: Text(
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 30,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                    Positioned(
                      top: 665,
                      left: 120,
                      child: IconButton(
                        onPressed: () => setState(() {
                              isPressed = true;
                            }),
                        icon: Icon(
                          Icons.home,
                          size: 40,
                          color: (isPressed) ? Colors.black : Colors.grey[400],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 665,
                      right: 120,
                      child: IconButton(
                        onPressed: () => setState(() {
                              isPressed = false;
                            }),
                        icon: Icon(
                          Icons.info_outline,
                          size: 40,
                          color: (!isPressed) ? Colors.black : Colors.grey[400],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Positioned(
                      top: 500,
                      left: 50,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ToothpickPattern()),
                          );
                        },
                        child: Material(
                          elevation: 10,
                          shadowColor: Colors.blueAccent[700],
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.blue,
                          child: Container(
                            width: 240,
                            height: 75,
                            color: Colors.transparent,
                            child: Center(
                              child: Text(
                                "START",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    (isPressed)
                        ? Positioned(
                            top: 60,
                            left: 140,
                            child: Image.asset('assets/gifs/toothpick.gif'),
                          )
                        : Positioned(
                            top: 110,
                            left: 60,
                            child: Text(
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 30,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                    (isPressed)
                        ? Positioned(
                            top: 320,
                            left: 80,
                            child: Text(
                              "Lorem Ipsum Dolor\nSit Amet",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 30,
                              ),
                            ),
                          )
                        : Positioned(
                            top: 250,
                            left: 60,
                            child: Text(
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 30,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                    Positioned(
                      top: 665,
                      left: 120,
                      child: IconButton(
                        onPressed: () => setState(() {
                              isPressed = true;
                            }),
                        icon: Icon(
                          Icons.home,
                          size: 40,
                          color: (isPressed) ? Colors.black : Colors.grey[400],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 665,
                      right: 120,
                      child: IconButton(
                        onPressed: () => setState(() {
                              isPressed = false;
                            }),
                        icon: Icon(
                          Icons.info_outline,
                          size: 40,
                          color: (!isPressed) ? Colors.black : Colors.grey[400],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Positioned(
                      top: 500,
                      left: 50,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => CountingHome()),
                          );
                        },
                        child: Material(
                          elevation: 10,
                          shadowColor: Colors.amberAccent[700],
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.amber[600],
                          child: Container(
                            width: 240,
                            height: 75,
                            color: Colors.transparent,
                            child: Center(
                              child: Text(
                                "START",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    (isPressed)
                        ? Positioned(
                            top: 30,
                            left: 140,
                            child: Image.asset('assets/gifs/counting.gif'),
                            height: 250,
                            width: 238,
                          )
                        : Positioned(
                            top: 110,
                            left: 60,
                            child: Text(
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 30,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                    (isPressed)
                        ? Positioned(
                            top: 320,
                            left: 80,
                            child: Text(
                              "Lorem Ipsum Dolor\nSit Amet",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 30,
                              ),
                            ),
                          )
                        : Positioned(
                            top: 250,
                            left: 60,
                            child: Text(
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 30,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                    Positioned(
                      top: 665,
                      left: 120,
                      child: IconButton(
                        onPressed: () => setState(() {
                              isPressed = true;
                            }),
                        icon: Icon(
                          Icons.home,
                          size: 40,
                          color: (isPressed) ? Colors.black : Colors.grey[400],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 665,
                      right: 120,
                      child: IconButton(
                        onPressed: () => setState(() {
                              isPressed = false;
                            }),
                        icon: Icon(
                          Icons.info_outline,
                          size: 40,
                          color: (!isPressed) ? Colors.black : Colors.grey[400],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Positioned(
                      top: 500,
                      left: 50,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => CountingTillN()),
                          );
                        },
                        child: Material(
                          elevation: 10,
                          shadowColor: Colors.deepPurpleAccent[700],
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.deepPurple[600],
                          child: Container(
                            width: 240,
                            height: 75,
                            color: Colors.transparent,
                            child: Center(
                              child: Text(
                                "START",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    (isPressed)
                        ? Positioned(
                            top: -20,
                            left: 115,
                            child: Image.asset('assets/gifs/count_n.gif'),
                            height: 352,
                            width: 264,
                          )
                        : Positioned(
                            top: 110,
                            left: 60,
                            child: Text(
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 30,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                    (isPressed)
                        ? Positioned(
                            top: 320,
                            left: 80,
                            child: Text(
                              "Lorem Ipsum Dolor\nSit Amet",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 30,
                              ),
                            ),
                          )
                        : Positioned(
                            top: 250,
                            left: 60,
                            child: Text(
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n"
                              "Lorem Ipsum Dolor Sit Amet\n",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 30,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                    Positioned(
                      top: 665,
                      left: 120,
                      child: IconButton(
                        onPressed: () => setState(() {
                              isPressed = true;
                            }),
                        icon: Icon(
                          Icons.home,
                          size: 40,
                          color: (isPressed) ? Colors.black : Colors.grey[400],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 665,
                      right: 120,
                      child: IconButton(
                        onPressed: () => setState(() {
                              isPressed = false;
                            }),
                        icon: Icon(
                          Icons.info_outline,
                          size: 40,
                          color: (!isPressed) ? Colors.black : Colors.grey[400],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
