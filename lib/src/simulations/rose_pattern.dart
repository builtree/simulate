import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

GlobalKey<_RoseState> globalKey = GlobalKey<_RoseState>();
class RosePattern extends StatefulWidget {
  @override
  _RosePatternState createState() => _RosePatternState();
}

class _RosePatternState extends State<RosePattern> {
  double _n = 0;
  double _d = 0;
  double k = 0;
  double offset = 0;
  bool animate = false;
  bool animating = false;

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
    ScreenUtil.init(
      context,
      width: 512.0,
      height: 1024.0,
      allowFontScaling: true,
    );
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
          'Rose Pattern',
          style: Theme.of(context).textTheme.title,
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(8.0),
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
                onPressed: (){
                  setState(() {
                    animating = !animating;
                  });
                },
              )
              ,FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.highlight_off,
                  color: Colors.black,
                ),
                onPressed: (){
                  setState(() {
                    globalKey.currentState.clearScreen();
                  });
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: ScreenUtil().setHeight(1024/5),
        child: Material(
          elevation: 30,
          color: Theme.of(context).primaryColor,
          child: ListView(
            padding: EdgeInsets.all(8.0),
            children: <Widget>[
              Slider(
                min: 0,
                max: 10,
                divisions: 1000,
                activeColor: Theme.of(context).accentColor,
                inactiveColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    _n = double.parse(value.toStringAsFixed(2));
                  });
                },
                value: _n,
              ),
              Center(
                child: Text(
                  "Numerator: $_n",
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
              Slider(
                min: 0,
                max: 10,
                divisions: 1000,
                activeColor: Theme.of(context).accentColor,
                inactiveColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    _d = double.parse(value.toStringAsFixed(2));
                  });
                },
                value: _d,
              ),
              Center(
                child: Text(
                  "Denominator: $_d",
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
              Slider(
                min: 0,
                max: 1,
                divisions: 100,
                activeColor: Theme.of(context).accentColor,
                inactiveColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    offset = double.parse(value.toStringAsFixed(2));
                  });
                },
                value: offset,
              ),
              Center(
                child: Text(
                  "Offset: $offset",
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Rose(
              d:_d,
              n:_n,
              c:offset,
              animate:animate,
              animating:animating,
              key: globalKey,
            ),
            Positioned(
              top: 5,
              left: 5,
              child: Text(
                'k ~ ${(_n / _d).toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.subtitle,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text("Animate"),
                  Checkbox(
                    onChanged: (_){
                      setState(() {
                        animate=!animate;
                        if(animating)
                          animating = (animating && animate);
                      });
                    },
                    value: animate,
                    activeColor: Colors.red,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Rose extends StatefulWidget {
  Rose({
    Key key,
    @required this.d,
    @required this.n,
    @required this.c,
    @required this.animate,
    @required this.animating
  }) :super(key:key);

  final double d;
  final double n;
  final double c;
  final bool animate;
  final bool animating;
  @override
  _RoseState createState() => _RoseState();
}

class _RoseState extends State<Rose> {
  List<Offset> points = [];
  double loopi = 0;
  double r, k;
  double looplength = 2 * pi;


  void dispose() {
    super.dispose();
  }

  void clearScreen() {
    points.clear();
    looplength = 2 * pi * widget.d;
    looplength+=loopi;
  }

  nextStep()
  {
    if(loopi>=looplength)
    {
      clearScreen();
      loopi=0;
    }

    setState(() {
      if(!(widget.d==0)&&!(widget.d==0&&widget.n==0)){
        if(loopi == 0) {
          looplength = 2 * pi * widget.d;
        }
        loopi += 0.04;
        k = widget.n / widget.d;
        r = (MediaQuery.of(context).size.width / 4).roundToDouble();
        points.add(Offset(r * (cos(k * loopi) + widget.c) * cos(loopi), r * (cos(k * loopi) + widget.c) * sin(loopi))
            .translate((MediaQuery.of(context).size.width / 2).roundToDouble(), (MediaQuery.of(context).size.height / 3).roundToDouble()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(widget.animating) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        nextStep();
      });
    }

    return CustomPaint(
      painter: RosePainter(
          widget.d,
          widget.n,
          (MediaQuery.of(context).size.width / 2).roundToDouble(),
          (MediaQuery.of(context).size.height / 3).roundToDouble(),
          (MediaQuery.of(context).size.width / 4).roundToDouble(),
          widget.c,
          widget.animate,
          points),
      child: Container(),
    );
  }
}


class RosePainter extends CustomPainter {
  double d, r, n, c;
  double k, transformx, transformy;
  List<Offset> points = [];
  bool animate;
  RosePainter(
      this.d, this.n, this.transformx, this.transformy, this.r, this.c,this.animate, points) {
    k = n / d;
    this.points = new List<Offset>.from(points);
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    paint.strokeWidth = 2;
    if(!animate) {
      this.points.clear();
      for (double i = 0; i < 2 * d * pi; i += 0.01) {
        points.add(
            Offset(r * (cos(k * i) + c) * cos(i), r * (cos(k * i) + c) * sin(i))
                .translate(transformx, transformy));
      }
    }
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(RosePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(RosePainter oldDelegate) => false;
}
