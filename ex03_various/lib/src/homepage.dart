import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../src/blocs/animated_object_bloc.dart';
import '../src/blocs/bloc_provider.dart';
import '../src/blocs/staged_widget_bloc.dart';
import '../src/blocs/timer_object_bloc.dart';

import 'screens/animated_object_page.dart';
import 'screens/blur_page.dart';
import 'screens/curvedtransition_page.dart';
import 'screens/lineartransition_page.dart';
import 'screens/staged_widget_page.dart';
import 'screens/timer_object_page.dart';

class MyExpansionTile extends StatelessWidget {
  const MyExpansionTile({Key key, this.title, this.widgets}) : super(key: key);

  final String title;
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        backgroundColor: Colors.white,
        title: Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        children: widgets);
  }
}

class MyTile extends StatelessWidget {
  const MyTile({Key key, this.title, this.onTap}) : super(key: key);

  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
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
}

class HomePage extends StatelessWidget {
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
            children: [
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
              MyExpansionTile(
                title: 'Timing and animations',
                widgets: [
                  MyTile(
                    title: 'TimerObject',
                    onTap: () {
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
                    },
                  ),
                  MyTile(
                    title: 'AnimatedObject',
                    onTap: () {
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
                    },
                  ),
                  MyTile(
                    title: 'StagedWidget',
                    onTap: () {
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
                    },
                  ),
                ],
              ),
              MyExpansionTile(
                title: 'Effects',
                widgets: [
                  MyTile(
                    title: 'Blur',
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlurPage(),
                        ),
                      );
                    },
                  ),
                  MyTile(
                    title: 'CurvedTransition',
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CurvedTransitionPage(),
                        ),
                      );
                    },
                  ),
                  MyTile(
                    title: 'LinearTransition',
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LinearTransitionPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
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
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
