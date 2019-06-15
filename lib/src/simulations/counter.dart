import 'package:flutter/material.dart';

final coolController = TextEditingController();
int N;
List<int> numbers = [];
final List<int> colors = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];

class CountingTillN extends StatefulWidget {
  _CountingTillNState createState() => _CountingTillNState();
}

class _CountingTillNState extends State<CountingTillN> {
  void change() {
    N = int.parse(coolController.text);
    numbers.clear();
    for (int i = 0; i <= N; i++) numbers.add(i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counting Till N'),
        backgroundColor: Colors.red[500],
      ),
      body: Center(
        child: Container(
          width: 300.0,
          child: TextField(
            controller: coolController,
            decoration: InputDecoration(hintText: 'Enter a number'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.done,
          color: Colors.white,
        ),
        backgroundColor: Colors.red[500],
        onPressed: () {
          change();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NumbersList()));
        },
      ),
    );
  }
}

class NumbersList extends StatefulWidget {
  _NumbersListState createState() => _NumbersListState();
}

class _NumbersListState extends State<NumbersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Numbers'),
        backgroundColor: Colors.red[500],
      ),
      body: Center(
        child: Container(
          color: Colors.grey[400],
          alignment: Alignment(0, 0),
          child: ListView.builder(
            itemCount: N + 1,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 40,
                color: Colors.amber[colors[index % 10]],
                child: Center(
                  child: Text('Number: ${numbers[index]}'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
