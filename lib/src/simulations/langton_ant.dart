import 'package:flutter/material.dart';
import 'dart:io';

final size = 25;

class LangtonAnt extends StatefulWidget {
  _LangtonAntState createState() => _LangtonAntState();
}

class _LangtonAntState extends State<LangtonAnt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Langton's Ant"),
        backgroundColor: Colors.red[500],
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height / 2,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: size,
            ),
            itemCount: size * size,
            itemBuilder: buildItem,
            padding: EdgeInsets.all(5.0),
          ),
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return GridTile(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0.8),
          color: Colors.orange,
        ),
      ),
    );
  }
}
