import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'data/simulations.dart';
import 'package:provider/provider.dart';
import 'package:simulate/src/custom_items/home_page.dart';
import 'package:simulate/src/custom_items/mathematics_page.dart';
import 'package:simulate/src/custom_items/algorithms_page.dart';
import 'package:simulate/src/custom_items/simulation_card.dart';
import 'package:simulate/src/data/themedata.dart';

class Home extends StatefulWidget {
  final List<Widget> _categoryTabs = [
    Tab(
      child: Text('Home'),
    ),
    Tab(
      child: Text('Algorithms'),
    ),
    Tab(
      child: Text('Mathematics'),
    ),
  ];
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _categoryController;
  @override
  void initState() {
    super.initState();
    _categoryController = TabController(
      vsync: this,
      length: 3,
    );
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Simulate',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SimulationSearch(),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _categoryController,
          isScrollable: true,
          tabs: widget._categoryTabs,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Text(
                  'Simulate',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontSize: 40,
                      ),
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            ListTile(
              leading: Text(
                "Dark Mode",
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontSize: 20,
                    ),
              ),
              trailing: Switch(
                value: theme.darkTheme,
                activeColor: Colors.black,
                onChanged: (bool value) {
                  theme.toggleTheme();
                },
              ),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _categoryController,
        children: <Widget>[
          HomePage(),
          AlgorithmsPage(),
          MathematicsPage(),
        ],
      ),
    );
  }
}

class SimulationSearch extends SearchDelegate<SimulationCard> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final appState = Provider.of<Simulations>(context);
    return (query != '')
        ? (appState.searchSims(query).length != 0)
            ? GridView.count(
                crossAxisCount: (MediaQuery.of(context).size.width < 600)
                    ? 2
                    : (MediaQuery.of(context).size.width / 200).floor(),
                children: appState.searchSims(query),
              )
            : Container(
                child: Center(
                  child: Text(
                    "Sorry, couldn't find a simulation",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              )
        : Container(
            child: Center(
              child: Text(
                'Search for Simulations',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          );
  }
}
