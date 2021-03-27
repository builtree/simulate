import 'package:flutter/material.dart';
import 'package:simulate/src/custom_items/simulation_card.dart';
import 'package:simulate/src/data/themedata.dart';
import 'package:simulate/src/simulations/bubble_sort.dart';
import 'package:simulate/src/simulations/epicycloid.dart';
import 'package:simulate/src/simulations/fourier_series.dart';
import 'package:simulate/src/simulations/pigeonhole_sort.dart';
import 'package:simulate/src/simulations/rose_pattern.dart';
import 'package:simulate/src/simulations/toothpick.dart';
import 'package:simulate/src/simulations/insertion_sort.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simulate/src/simulations/lissajous_curve.dart';
import 'package:simulate/src/simulations/epicycloid_curve.dart';
import 'package:simulate/src/simulations/maurer_rose.dart';

class Simulations with ChangeNotifier {
  static var _favorites = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
  final _algorithm = [0, 1, 2, 3];
  final _mathematics = [4, 5, 6, 7, 8, 9];
  final _physics = [];
  final _chemistry = [];
  var prefs;
  final _searchTags = {
    0: "toothpick pattern algorithm sequence ",
    1: "bubble sort algorithm sorting bars ",
    2: "insertion sort algorithm sorting bars ",
    3: "pigeonhole sort algorithm sorting bars",
    4: "rose pattern mathematics sequence ",
    5: "fourier series mathematics ",
    6: "lissajous curve pattern mathematics animation ",
    7: "epicycloid curve pattern mathematics animation pencil lines ",
    8: "epicycloid curve pattern mathematics animation ",
    9: "maurer rose pattern mathematics animation",
  };

  Simulations() {
    getFavorites();
  }

  getFavorites() async {
    prefs = await SharedPreferences.getInstance();
    List<String> myList = (prefs.getStringList('favorites') ?? List<String>());
    if (myList.length != 0) {
      _favorites = myList.map((i) => int.parse(i)).toList();
      if (allSimulations().length > _favorites.length) {
        _favorites = List.from(_favorites)
          ..addAll(
              List.filled(allSimulations().length - _favorites.length, -1));
      }
    }
  }

  List<Widget> allSimulations() {
    final theme = ThemeProvider(prefs);
    return <Widget>[
      SimulationCard(
        id: 0,
        simulationName: 'Toothpick Pattern',
        image: theme.darkTheme
            ? 'assets/simulations/ToothpickPatternDark.png'
            : 'assets/simulations/ToothpickPatternLight.png',
        direct: ToothpickPattern(),
        infoLink: 'https://en.wikipedia.org/wiki/Toothpick_sequence',
        fav: _favorites[0],
      ),
      SimulationCard(
        id: 1,
        simulationName: 'Bubble Sort (Bars)',
        image: theme.darkTheme
            ? 'assets/simulations/BubbleSortDark.png'
            : 'assets/simulations/BubbleSortLight.png',
        direct: BubbleSortBars(),
        infoLink: 'https://en.wikipedia.org/wiki/Bubble_sort',
        fav: _favorites[1],
      ),
      SimulationCard(
        id: 2,
        simulationName: 'Insertion Sort',
        image: theme.darkTheme
            ? 'assets/simulations/InsertionSortDark.png'
            : 'assets/simulations/InsertionSortLight.png',
        direct: InsertionHome(),
        infoLink: 'https://en.wikipedia.org/wiki/Insertion_sort',
        fav: _favorites[2],
      ),
      SimulationCard(
        id: 3,
        simulationName: 'Pigeonhole Sort',
        direct: PigeonholeSort(),
        //TODO: change the image below
        image: theme.darkTheme
            ? 'assets/simulations/pigeonhole_dark.png'
            : 'assets/simulations/pigeonhole_light.png',
        infoLink: 'https://en.wikipedia.org/wiki/Pigeonhole_sort',
        fav: _favorites[3],
      ),
      SimulationCard(
        id: 4,
        simulationName: 'Rose Pattern',
        image: theme.darkTheme
            ? 'assets/simulations/RosePatternDark.png'
            : 'assets/simulations/RosePatternLight.png',
        direct: RosePattern(),
        infoLink: 'https://en.wikipedia.org/wiki/Rose_(mathematics)',
        fav: _favorites[4],
      ),
      SimulationCard(
        id: 5,
        simulationName: 'Fourier Series',
        image: theme.darkTheme
            ? 'assets/simulations/FourierSeriesDark.png'
            : 'assets/simulations/FourierSeriesLight.png',
        direct: FourierSeries(),
        infoLink: 'https://en.wikipedia.org/wiki/Fourier_series',
        fav: _favorites[5],
      ),
      SimulationCard(
        id: 6,
        simulationName: 'Lissajous Pattern',
        image: theme.darkTheme
            ? 'assets/simulations/LissajousCurveDark.png'
            : 'assets/simulations/LissajousCurveLight.png',
        direct: LissajousCurve(),
        infoLink: 'https://en.wikipedia.org/wiki/Lissajous_curve',
        fav: _favorites[6],
      ),
      SimulationCard(
        id: 7,
        simulationName: 'Epicycloid Pattern (Pencil of Lines)',
        image: theme.darkTheme
            ? 'assets/simulations/Epicycloid1Dark.png'
            : 'assets/simulations/Epicycloid1Light.png',
        direct: EpicycloidCurve(),
        infoLink: 'https://en.wikipedia.org/wiki/Epicycloid',
        fav: _favorites[7],
      ),
      SimulationCard(
        id: 8,
        simulationName: 'Epicycloid Curve',
        image: theme.darkTheme
            ? 'assets/simulations/EpicycloidDark.png'
            : 'assets/simulations/Epicycloid.png',
        direct: NormalEpicycloidCurve(),
        infoLink: 'https://en.wikipedia.org/wiki/Epicycloid',
        fav: _favorites[8],
      ),
      SimulationCard(
        id: 9,
        simulationName: 'Maurer Rose Pattern',
        image: theme.darkTheme
            ? 'assets/simulations/MaurerRoseDark.png'
            : 'assets/simulations/MaurerRoseLight.png',
        direct: MaurerRoseCurve(),
        infoLink: 'https://en.wikipedia.org/wiki/Maurer_rose',
        fav: _favorites[9],
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
