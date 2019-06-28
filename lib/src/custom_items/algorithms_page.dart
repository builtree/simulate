import 'package:flutter/material.dart';
import '../simulations/simulations.dart';

class AlgorithmsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: (MediaQuery.of(context).size.width / 200).floor(),
        children: Simulations.returnWidgets([0,1])
      ),
    );
  }
}
