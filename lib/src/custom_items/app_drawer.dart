import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:simulate/src/data/themedata.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  _launch(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return Drawer(
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
              "Documentation",
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontSize: 20,
                  ),
            ),
            trailing: Icon(Icons.open_in_new_rounded),
            onTap: () => _launch("https://www.builtree.org/simulate/"),
          ),
          ListTile(
            leading: Text(
              "License",
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontSize: 20,
                  ),
            ),
            trailing: Icon(Icons.open_in_new_rounded),
            onTap: () => _launch(
              "https://github.com/builtree/simulate/blob/master/LICENSE",
            ),
          ),
          ListTile(
            leading: Text(
              "Github",
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontSize: 20,
                  ),
            ),
            trailing: Icon(Icons.open_in_new_rounded),
            onTap: () => _launch("https://github.com/builtree/simulate/"),
          ),
          ListTile(
            leading: Text(
              "Submit an issue",
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontSize: 20,
                  ),
            ),
            trailing: Icon(Icons.open_in_new_rounded),
            onTap: () => _launch(
              "https://github.com/builtree/simulate/issues/new/choose",
            ),
          ),
          ListTile(
            leading: Text(
              "App Version",
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontSize: 20,
                  ),
            ),
            trailing: Text(
              "1.0.0",
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontSize: 20,
                  ),
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
          ),
          InkWell(
            child: SvgPicture.asset(
              "assets/images/builtree.svg",
              width: 100,
            ),
            onTap: () => _launch("https://www.builtree.org/"),
          ),
        ],
      ),
    );
  }
}
