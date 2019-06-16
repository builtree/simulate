import 'package:flutter/material.dart';

class CountingHome extends StatefulWidget {
  @override
  _CountingHomeState createState() => _CountingHomeState();
}

class _CountingHomeState extends State<CountingHome> {
  int _counter = 0;
  final countingController = TextEditingController();

  change() {
    setState(() {
      _counter = int.parse(countingController.text.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counting'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: 300,
            child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: countingController,
                decoration: InputDecoration(hintText: 'Enter a Number'),
                onChanged: (text) {
                  change();
                }),
          ),
          Expanded(
            child: Center(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5),
                children: List<Widget>.generate(_counter, (int index) {
                  return Card(
                    child: Center(
                      child: Text((index + 1).toString()),
                    ),
                    color: Colors.red,
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
