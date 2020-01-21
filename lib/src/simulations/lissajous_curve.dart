import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LissajousSim extends StatefulWidget {
  LissajousSimState createState() => LissajousSimState();
}

class LissajousSimState extends State<LissajousSim> {
  double sliderVala = 0, sliderValb = 0, sliderPhaseDiff = 0, sliderA = 0, sliderB = 0;
  MyPainter myPainter;

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
        centerTitle: true,
        title: Text(
          'Lissajous Curve',
          style: TextStyle(
            fontFamily: 'Ubuntu',
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.55,
            child: Column(children: <Widget>[
              Slider(
                value: sliderVala,
                onChanged: (double val) {
                  setState(() {
                    sliderVala = val;
                  });
                },
                min: 0,
                max: 10,
                activeColor: Colors.black,
                inactiveColor: Colors.grey,
                divisions: 20,
              ),Text(
                  "a: ${double.parse((sliderVala).toStringAsFixed(2))}",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              Slider(
                value: sliderValb,
                onChanged: (double val) {
                  setState(() {
                    sliderValb = val;
                  });
                },
                min: 0,
                max: 10,
                activeColor: Colors.black,
                inactiveColor: Colors.grey,
                divisions: 20,
              ),
              Text(
                  "b: ${double.parse((sliderValb).toStringAsFixed(2))}",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Ubuntu',
                  ),
                ),
                Slider(
                value: sliderPhaseDiff,
                onChanged: (double val) {
                  setState(() {
                    sliderPhaseDiff = val;
                  });
                },
                min: 0,
                max: 2*pi,
                activeColor: Colors.black,
                inactiveColor: Colors.grey,
                
              ),
              Text(
                  "Phase Diff: ${double.parse((sliderPhaseDiff).toStringAsFixed(2))}",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Ubuntu',
                  ),
                ),
                 Slider(
                value: sliderA,
                onChanged: (double val) {
                  setState(() {
                    sliderA = val;
                  });
                },
                min: 0,
                max: 10,
                activeColor: Colors.black,
                inactiveColor: Colors.grey,
                
              ),
              Text(
                  "A: ${double.parse((sliderA).toStringAsFixed(2))}",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Ubuntu',
                  ),
                ),
                 Slider(
                value: sliderB,
                onChanged: (double val) {
                  setState(() {
                    sliderB = val;
                  });
                },
                min: 0,
                max: 10,
                activeColor: Colors.black,
                inactiveColor: Colors.grey,
                
              ),
              Text(
                  "B: ${double.parse((sliderB).toStringAsFixed(2))}",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Ubuntu',
                  ),
                ),
            ])),
      ),
      body: Container(
          child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width,
        child: CustomPaint(
          painter: MyPainter(sliderVala, sliderValb, sliderPhaseDiff, sliderA, sliderB),
        ),
      )),
    );
  }
}

class MyPainter extends CustomPainter {
  double a, b, gam, c1, c2;
  MyPainter(this.a, this.b, this.gam, this.c1, this.c2);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5;
    canvas.drawLine(Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height), linePaint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(size.width, size.height / 2), linePaint);

    final curvePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2;

    double increment = 0.01;
    double pixelsPerUnit = 30;
    
   final gridPaint = Paint()..color = Colors.grey
                            ..strokeWidth = 1;

    for(double x = size.width/2 % pixelsPerUnit - pixelsPerUnit; x <= size.width; x += pixelsPerUnit){
       canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for(double y = size.height/2 % pixelsPerUnit - pixelsPerUnit; y <= size.height; y += pixelsPerUnit){
       canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    /*
    double timePeriod = 0;
    if(a != 0 && b!= 0){
      timePeriod = 2*pi;
    
    }
    */
    

    for (double i = 0, j = increment; j <= 20*pi; i += increment, j += increment) {
      //print(sin(i) * 100);
      canvas.drawLine(
          Offset(c1 * sin(a * i + gam) * pixelsPerUnit + size.width / 2,
              c2 * sin(b * i) * pixelsPerUnit + size.height / 2),
          Offset(c1 * sin(a * j + gam) * pixelsPerUnit + size.width / 2,
              c2 * sin(b * j) * pixelsPerUnit + size.height / 2),
          curvePaint);
    }
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return a != oldDelegate.a || b != oldDelegate.b;
  }
}
