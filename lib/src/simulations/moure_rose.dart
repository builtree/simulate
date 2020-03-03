import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:math' as math;


class MoureRoseCurve extends StatefulWidget {
  @override
  _MoureRoseCurveState createState() => _MoureRoseCurveState();
}

class _MoureRoseCurveState extends State<MoureRoseCurve> {
  var child;

  @override
  Widget build(BuildContext context) {
    

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
          'MoureRose Pattern',
          style: Theme.of(context).textTheme.title,
        ),
        centerTitle: true,
      ),
      body: Container(
          child: Center (
            child:CustomPaint(
              size: Size(800, 800),
              painter: MoureRosePainter(),)
           ,),
      ),
    );
    
  }
}

class MoureRosePainter extends CustomPainter {

List<Offset> points = [];
List<Offset> points2 = [];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4;

    for(var theta=0; theta <= 360; theta++) {
    var k = theta * 71 * math.pi/180;
    var r = 300 * math.sin(6*k);
    var x = r*math.cos(k) + 150;
    var y = r*math.sin(k) + 150;
    points.add(Offset(x,y));

    }

    canvas.drawPoints(PointMode.polygon, points, paint);

    final paint2 = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4;

    for(var theta=0; theta <= 360; theta++) {
    var k = theta * 71 * math.pi/180;
    var r = 300 * math.sin(6*k);
    var x = r*math.cos(k) + 150;
    var y = r*math.sin(k) + 150;
    points2.add(Offset(x,y));

    }

    canvas.drawPoints(PointMode.polygon, points, paint2);
   
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
  
}