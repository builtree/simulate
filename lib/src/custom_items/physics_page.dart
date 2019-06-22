import 'package:flutter/material.dart';
import 'simulation_card.dart';

class PhysicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: (MediaQuery.of(context).size.width / 200).floor(),
        children: <Widget>[
        ],
      ),
    );
  }
}
