import 'package:flutter/material.dart';
import 'dart:math' as math;

class PiApproximation extends StatefulWidget {
  _PiApproximationState createState() => _PiApproximationState();
}

class _PiApproximationState extends State<PiApproximation> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    return Scaffold();
  }
}
