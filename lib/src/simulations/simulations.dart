import 'package:flutter/material.dart';
import 'package:simulate/src/custom_items/simulation_card.dart';
import 'package:simulate/src/simulations/toothpick.dart';
import 'package:simulate/src/simulations/langton_ant.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:async/async.dart';

class Simulations with ChangeNotifier {
  static var _favorites = [-1, -1];
  final _algorithm = [0, 1];
  var prefs;
  Simulations() {
    getFavorites();
  }

  getFavorites() async {
    prefs = await SharedPreferences.getInstance();
    List<String> myList = (prefs.getStringList('favorites') ?? List<String>());
    if (myList.length != 0) {
      _favorites = myList.map((i) => int.parse(i)).toList();
    }
  }

  List<Widget> allSimulations() {
    return <Widget>[
      SimulationCard(
        id: 0,
        simulationName: 'ToothPick Pattern',
        image: 'images/ToothpickPattern.gif',
        direct: ToothpickPattern(),
        infoLink: 'https://en.wikipedia.org/wiki/Toothpick_sequence',
        fav: _favorites[0],
      ),
      SimulationCard(
        id: 1,
        simulationName: 'Langton\'s Ant',
        image: 'images/LangtonsAnt.gif',
        direct: LangtonAnt(),
        infoLink: 'https://en.wikipedia.org/wiki/Langton%27s_ant',
        fav: _favorites[1],
      ),
    ];
  }

  List<Widget> get algorithms {
    getFavorites();
    List<Widget> widgets = [];
    List<Widget> allWidgets = allSimulations();
    // print(_favorites);s
    _algorithm.forEach((index) => widgets.add(allWidgets[index]));
    return widgets;
  }

  void toggleFavorite(int index) async {
    _favorites[index] *= -1;
    List<String> favorites = _favorites.map((i) => i.toString()).toList();
    await prefs.setStringList('favorites', favorites);
    // print(favorites);
    notifyListeners();
  }
}
