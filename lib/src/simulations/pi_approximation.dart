import 'package:flutter/material.dart';
import 'dart:math' as math;

double pi = 0, total = 0, insideCircle = 0;
List<List<double>> coordinates = List();

class PiApproximation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Pi Approximation",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Ubuntu',
          ),
        ),
      ),
      backgroundColor: Colors.grey[850],
      body: Stack(
        children: <Widget>[
          RepaintBoundary(
            child: CustomPaint(
              painter: BackgroundPainter(),
              willChange: false,
              isComplex: true,
              child: Container(),
            ),
          ),
          MakeDots(),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        height: size.height / 10,
        width: size.width,
        child: Material(
          color: Colors.white,
          shadowColor: Colors.black,
          elevation: 10,
          child: Center(
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 5,
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Approximate value of Pi: ",
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 18,
                          ),
                        ),
                        PiValue(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  double R;
  @override
  void paint(Canvas canvas, Size size) {
    R = size.width / 2.1;

    final brush = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      R,
      brush,
    );

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        height: 2 * R,
        width: 2 * R,
      ),
      brush,
    );
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BackgroundPainter oldDelegate) => false;
}

class PiValue extends StatefulWidget {
  _PiValueState createState() => _PiValueState();
}

class _PiValueState extends State<PiValue> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    return Text(
      "$pi",
      style: TextStyle(
        fontFamily: 'Ubuntu',
        fontSize: 18,
      ),
    );
  }
}

class MakeDots extends StatefulWidget {
  _MakeDotsState createState() => _MakeDotsState();
}

class _MakeDotsState extends State<MakeDots> {
  @override
  void dispose() {
    coordinates.clear();
    total = 0;
    insideCircle = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    return CustomPaint(
      painter: DotPainter(),
      child: Container(),
    );
  }
}

class DotPainter extends CustomPainter {
  var brush = Paint();
  final random = math.Random();
  double R;

  @override
  void paint(Canvas canvas, Size size) {
    double x, y;
    R = size.width / 2.1;

    for (int i = 0; i < 100; i++) {
      x = -R + 2 * random.nextDouble() * R;
      y = -R + 2 * random.nextDouble() * R;

      coordinates.add([x, y]);
      if (x * x + y * y <= R * R) ++insideCircle;
      ++total;
    }

    coordinates.forEach((coordinate) {
      x = coordinate[0];
      y = coordinate[1];

      (x * x + y * y > R * R)
          ? brush.color = Colors.greenAccent[400]
          : brush.color = Colors.red;

      canvas.drawCircle(
        Offset(size.width / 2 + x, size.height / 2 + y),
        1,
        brush,
      );
    });

    pi = 4 * insideCircle / total;
  }

  @override
  bool shouldRepaint(DotPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(DotPainter oldDelegate) => false;
}
