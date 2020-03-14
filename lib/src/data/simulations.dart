import 'package:flutter/material.dart';
import 'package:simulate/src/custom_items/simulation_card.dart';
import 'package:simulate/src/data/themedata.dart';
import 'package:simulate/src/simulations/bubble_sort.dart';
import 'package:simulate/src/simulations/fourier_series.dart';
import 'package:simulate/src/simulations/rose_pattern.dart';
import 'package:simulate/src/simulations/toothpick.dart';
import 'package:simulate/src/simulations/insertion_sort.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simulate/src/simulations/lissajous_curve.dart';
import 'package:simulate/src/simulations/epicycloid_curve.dart';
import 'package:simulate/src/simulations/maurer_rose.dart';

class Simulations with ChangeNotifier {
  static var _favorites = [-1, -1, -1, -1, -1, -1, -1, -1];
  final _algorithm = [0, 1, 2];
  final _mathematics = [3, 4, 5, 6, 7];
  final _physics = [];
  final _chemistry = [];
  var prefs;
  final _searchTags = {
    0: "toothpick pattern algorithm sequence ",
    1: "bubble sort algorithm sorting bars ",
    2: "insertion sort algorithm sorting bars ",
    3: "rose pattern mathematics sequence ",
    4: "fourier series mathematics ",
    5: "lissajous curve pattern mathematics animation ",
    6: "epicycloid curve pattern mathematics animation pencil lines ",
    7: "maurer rose pattern"
  };

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
    final theme = ThemeProvider(prefs);
    return <Widget>[
      SimulationCard(
        id: 0,
        simulationName: 'ToothPick Pattern',
        image: theme.darkTheme ? 'images/ToothpickPatternDark.png': 'images/ToothpickPatternLight.png',
        direct: ToothpickPattern(),
        infoLink: 'https://en.wikipedia.org/wiki/Toothpick_sequence',
        fav: _favorites[0],
      ),
      SimulationCard(
        id: 1,
        simulationName: 'Bubble Sort (Bars)',
        image: 'images/Bubblesort.gif',
        direct: BubbleSortBars(),
        infoLink: 'https://en.wikipedia.org/wiki/Bubble_sort',
        fav: _favorites[1],
      ),
      SimulationCard(
        id: 2,
        simulationName: 'Insertion Sort',
        image: 'images/InsertionSort.gif',
        direct: InsertionHome(),
        infoLink: 'https://en.wikipedia.org/wiki/Insertion_sort',
        fav: _favorites[2],
      ),
      SimulationCard(
        id: 3,
        simulationName: 'Rose Pattern',
        image: theme.darkTheme ? 'images/RosePatternDark.png': 'images/RosePatternLight.png',
        direct: RosePattern(),
        infoLink: 'https://en.wikipedia.org/wiki/Rose_(mathematics)',
        fav: _favorites[3],
      ),
      SimulationCard(
        id: 4,
        simulationName: 'Fourier Series',
        image: theme.darkTheme ? 'images/FourierSeriesDark.png': 'images/FourierSeriesLight.png',
        direct: FourierSeries(),
        infoLink: 'https://en.wikipedia.org/wiki/Fourier_series',
        fav: _favorites[4],
      ),
      SimulationCard(
        id: 5,
        simulationName: 'Lissajous Pattern',
        image: theme.darkTheme ? 'images/LissajousCurveDark.png': 'images/LissajousCurveLight.png',
        direct: LissajousCurve(),
        infoLink: 'https://en.wikipedia.org/wiki/Lissajous_curve',
        fav: _favorites[5],
      ),
      SimulationCard(
        id: 6,
        simulationName: 'Epicycloid Pattern (Pencil of Lines)',
        image: theme.darkTheme ? 'images/Epicycloid1Dark.png': 'images/Epicycloid1Light.png',
        direct: EpicycloidCurve(),
        infoLink: 'https://en.wikipedia.org/wiki/Epicycloid',
        fav: _favorites[6],
      ),
      SimulationCard(
        id: 7,
        simulationName: 'Maurer Rose Pattern',
        image: 'images/Maurer_Rose.svg.png',
        direct: MaurerRoseCurve(),
        infoLink: 'https://en.wikipedia.org/wiki/Maurer_rose',
        fav: _favorites[7],
      ),
    ];
  }

  List<Widget> get all {
    getFavorites();
    return allSimulations();
  }

  List<Widget> get algorithms {
    getFavorites();
    List<Widget> widgets = [];
    List<Widget> allWidgets = allSimulations();
    _algorithm.forEach((index) => widgets.add(allWidgets[index]));
    return widgets;
  }

  List<Widget> get physics {
    getFavorites();
    List<Widget> widgets = [];
    List<Widget> allWidgets = allSimulations();
    _physics.forEach((index) => widgets.add(allWidgets[index]));
    return widgets;
  }

  List<Widget> get mathematics {
    getFavorites();
    List<Widget> widgets = [];
    List<Widget> allWidgets = allSimulations();
    _mathematics.forEach((index) => widgets.add(allWidgets[index]));
    return widgets;
  }

  List<Widget> get chemistry {
    getFavorites();
    List<Widget> widgets = [];
    List<Widget> allWidgets = allSimulations();
    _chemistry.forEach((index) => widgets.add(allWidgets[index]));
    return widgets;
  }

  List<Widget> get favorites {
    getFavorites();
    List<Widget> widgets = [];
    List<Widget> allWidgets = allSimulations();
    for (int i = 0; i < _favorites.length; ++i) {
      if (_favorites[i] == 1) {
        widgets.add(allWidgets[i]);
      }
    }
    return widgets;
  }

  List<Widget> searchSims(String query) {
    query = query.toLowerCase();
    List<Widget> widgets = [];
    List<Widget> allWidgets = allSimulations();
    final regex = RegExp('$query[a-z]* ');
    _searchTags.forEach((key, tags) {
      if (regex.hasMatch(tags)) {
        widgets.add(allWidgets[key]);
      }
    });
    return widgets;
  }

  void toggleFavorite(int index) async {
    _favorites[index] *= -1;
    List<String> favorites = _favorites.map((i) => i.toString()).toList();
    await prefs.setStringList('favorites', favorites);
    notifyListeners();
  }
}
