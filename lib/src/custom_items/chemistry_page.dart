import 'package:flutter/material.dart';
import 'package:simulate/src/data/simulations.dart';
import 'package:provider/provider.dart';

class ChemistryPage extends StatelessWidget {
  const ChemistryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<Simulations>(context);
    return GridView.count(
        crossAxisCount: (MediaQuery.of(context).size.width < 600)
            ? 2
            : (MediaQuery.of(context).size.width / 200).floor(),
        children: appState.chemistry);
  }
}
