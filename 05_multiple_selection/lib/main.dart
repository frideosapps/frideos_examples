import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import 'src/appstate.dart';

import 'src/screens/homepage.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final appState = AppState();

  @override
  Widget build(BuildContext context) {
    return AppStateProvider<AppState>(
      initAppState: false,
      appState: appState,
      child: MaterialPage(),
    );
  }
}

class MaterialPage extends StatefulWidget {
  @override
  _MaterialPageState createState() => _MaterialPageState();
}

class _MaterialPageState extends State<MaterialPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Multiple selection",
      theme: ThemeData.light(),
      home: HomePage(),
    );
  }
}
