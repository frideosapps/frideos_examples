import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../src/blocs/animated_object_bloc.dart';
import '../src/blocs/bloc_provider.dart';
import '../src/blocs/sliders_bloc.dart';
import '../src/blocs/staged_widget_bloc.dart';
import '../src/blocs/timer_object_bloc.dart';

import 'screens/animated_object_page.dart';
import 'screens/blur_page.dart';
import 'screens/curvedtransition_page.dart';
import 'screens/lineartransition_page.dart';
import 'screens/sliders_page.dart';
import 'screens/staged_widget_page.dart';
import 'screens/timer_object_page.dart';

class HomePage extends StatelessWidget {
  Widget _expansionTile(String title, List<Widget> widgets) {
    return ExpansionTile(
        backgroundColor: Colors.white,
        title: Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        children: widgets);
  }

  Widget _tile(String title, Function onTap) {
    return ListTile(
      dense: true,
      title: Text(title,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic)),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Various examples'),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blue[100],
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Center(
                  child: const Text(
                    'Various examples',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              _expansionTile('Timing and animations', [
                _tile('TimerObject', () {
                  Navigator.pop(context);

                  final bloc = TimerObjectBloc();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            bloc: bloc,
                            child: TimerObjectPage(),
                          ),
                    ),
                  );
                }),
                _tile('AnimatedObject', () {
                  Navigator.pop(context);

                  final bloc = AnimatedObjectBloc();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            bloc: bloc,
                            child: AnimatedObjectPage(),
                          ),
                    ),
                  );
                }),
                _tile('StagedWidget', () {
                  Navigator.pop(context);

                  final bloc = StagedWidgetBloc();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StagedWidgetPage(
                            bloc: bloc,
                          ),
                    ),
                  );
                }),
              ]),
              _expansionTile('Effects', [
                _tile('Blur', () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlurPage(),
                    ),
                  );
                }),
                _tile('CurvedTransition', () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CurvedTransitionPage(),
                    ),
                  );
                }),
                _tile('LinearTransition', () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LinearTransitionPage(),
                    ),
                  );
                }),
              ]),
              _expansionTile('Various', [
                _tile('Sliders', () {
                  Navigator.pop(context);

                  final bloc = SlidersBloc();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            bloc: bloc,
                            child: SlidersPage(),
                          ),
                    ),
                  );
                }),
              ]),
              const AboutListTile(),
            ],
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: LinearTransition(
          transitionDuration: 1000,
          firstWidget: Container(),
          secondWidget: Container(
            child: BlurWidget(
              sigmaX: 2,
              sigmaY: 2,
              child: WavesWidget(
                color: Colors.blue,
                child: Container(
                    color: Colors.blue[800],
                    alignment: Alignment.center,
                    child: FlutterLogo(
                      size: MediaQuery.of(context).size.width,
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
