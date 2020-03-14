import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

GlobalKey<MaurerRoseState> globalKey = GlobalKey<MaurerRoseState>();

class MourerRoseCurve extends StatefulWidget {
  @override
  MaurerRoseCurveState createState() => MaurerRoseCurveState();
}

class MaurerRoseCurveState extends State<MourerRoseCurve> {
  double _n = 0;
  double _d = 0;
  double k = 0;
  
  bool animate = false;
  bool animating = false;
  double thickness = 2;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: 512.0,
      height: 1024.0,
      allowFontScaling: true,
    )..init(context);
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
          'MourerRose Pattern',
          style: Theme.of(context).textTheme.title,
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible: animate,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.white,
                  child: (!animating)
                      ? Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                        )
                      : Icon(
                          Icons.pause,
                          color: Colors.black,
                        ),
                  onPressed: () {
                    setState(() {
                      animating = !animating;
                    });
                  }),
              FloatingActionButton(
                heroTag: null,
                child: Icon(
                  Icons.highlight_off,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                onPressed: () {
                  setState(() {
                    globalKey.currentState.clearscreen();
                  });
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: ScreenUtil.instance.height / 5,
        child: Material(
          elevation: 30,
          color: Theme.of(context).primaryColor,
          child: ListView(
            padding: EdgeInsets.all(8.0),
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Slider(
                min: 0,
                max: 10,
                divisions: 10,
                activeColor: Theme.of(context).accentColor,
                inactiveColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    _n = double.parse(value.toStringAsFixed(1));
                  });
                },
                value: _n,
              ),
              Center(
                child: Text(
                  "N: $_n",
                 // style: Theme.epicycloid_curveof(context).textTheme.subtitle,
                ),
              ),
              Slider(
                min: 0,
                max: 100,
                divisions: 100,
                activeColor: Theme.of(context).accentColor,
                inactiveColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    _d = double.parse(value.toStringAsFixed(1));
                  });
                },
                value: _d,
              ),
              Center(
                child: Text(
                  "D: $_d",
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
              
              Slider(
                min: 2,
                max: 6,
                divisions: 100,
                activeColor: Theme.of(context).accentColor,
                inactiveColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    thickness = double.parse(value.toStringAsFixed(2));
                  });
                },
                value: thickness,
              ),
              Center(
                child: Text("Thickness: $thickness",
                    style: Theme.of(context).textTheme.subtitle),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            MourerRose(
              d: _d,
              n: _n,
              animate: animate,
              animating: animating,
              key: globalKey,
              thickness: thickness,
            ),
            Positioned(
              top: 5,
              left: 5,
              child: Text(
                'N:D ~ ${(_n / _d).toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.subtitle,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('Animate: '),
                  Checkbox(
                    onChanged: (_) {
                      setState(() {
                        animate = !animate;
                        if (animating) {
                          animating = (animating && animate);
                        }
                      });
                    },
                    value: animate,
                    activeColor: Colors.red,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MourerRose extends StatefulWidget {
  MourerRose({
    Key key,
    @required double d,
    @required double n,
    @required this.animate,
    @required this.animating,
    @required this.thickness,
  })  : _d = d,
        _n = n,
        super(key: key);

  final double _d;
  final double _n;
  final bool animate;
  final bool animating;
  final double thickness;

  @override
  MaurerRoseState createState() => MaurerRoseState();
}

class MaurerRoseState extends State<MourerRose> {
  List<Offset> points = [];
  List<Offset> points2 = [];
  double loopi = 0;
  double loopi2 = 0;
  double r, n, d, c, transformx, transformy;
  double looplength = 360;
  double looplength2 = 360;

  void dispose() {
    super.dispose();
  }

  void clearscreen() {
    points.clear();
    points2.clear();
    looplength = 360;
    looplength2 = 360;
    looplength += loopi;
    looplength2 += loopi2;
  }

  nextStep() {
    if (loopi >= looplength) {
      clearscreen();
      loopi = 0;
      loopi2 = 0;
      looplength = 360;
      looplength2 = 360;
    }
    setState(() {
      sleep(Duration(milliseconds: 10));
      loopi += 1;
      
      points.add(Offset(300*sin(widget._n*loopi*widget._d*pi/180)*cos(loopi*widget._d*pi/180)/2,300*sin(widget._n*loopi*widget._d*pi/180)*sin(loopi*widget._d*pi/180)/2)
          .translate((MediaQuery.of(context).size.width / 2).roundToDouble(),
              (MediaQuery.of(context).size.height / 3).roundToDouble()));

              sleep(Duration(milliseconds: 10));
      loopi2 += 1;
      points2.add(Offset(300*sin(widget._n*loopi2*pi/180)*cos(loopi2*pi/180)/2,300*sin(widget._n*loopi2*pi/180)*sin(loopi2*pi/180)/2)
          .translate((MediaQuery.of(context).size.width / 2).roundToDouble(),
              (MediaQuery.of(context).size.height / 3).roundToDouble()));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animating) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        nextStep();
      });
    }
    return CustomPaint(
      painter: MourerRosePainter(
        widget._d,
        widget._n,
        (MediaQuery.of(context).size.width / 2).roundToDouble(),
        (MediaQuery.of(context).size.height / 3).roundToDouble(),
        
        
        widget.animate,
        points,
        points2,
        widget.thickness,
      ),
      child: Container(),
    );
  }
}

class MourerRosePainter extends CustomPainter {
  double d, n, c;
  double k, transformx, transformy;
  List<Offset> points = [];
  List<Offset> points2 = [];
  bool animate;
  double thickness;
  MourerRosePainter(
    this.d,
    this.n,
    this.transformx,
    this.transformy,
    
    
    this.animate,
    points,
    points2,
    this.thickness,
  ) {
    this.points = new List<Offset>.from(points);
    this.points2 = new List<Offset>.from(points2);
    k = n / d;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = thickness;
    if (!animate) {
      this.points.clear();
      for (var theta=0; theta <= 360; theta++) {
        var k = theta*d*pi/180;
        var q= 300*sin(n*k);
        var x = q*cos(k) ;
        var y = q*sin(k) ;
        this.points.add(Offset(x/2,y/2)
            .translate(transformx, transformy));
      }
    }
    canvas.drawPoints(PointMode.polygon, points, paint);

    var paint2 = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeWidth = thickness;

    if (!animate) {
      this.points2.clear();
      for (var theta=0; theta <= 360; theta++) {
        var k = theta*pi/180;
        var q= 300*sin(n*k);
        var x = q*cos(k) ;
        var y = q*sin(k) ;
        this.points2.add(Offset(x/2,y/2)
            .translate(transformx, transformy));
      }
    }
    canvas.drawPoints(PointMode.polygon, points2, paint2);
  }

  @override
  bool shouldRepaint(MourerRosePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MourerRosePainter oldDelegate) => false;
}
