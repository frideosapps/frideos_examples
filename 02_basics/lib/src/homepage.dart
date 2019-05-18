import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../src/blocs/bloc_provider.dart';
import '../src/blocs/streamed_list_bloc.dart';
import '../src/blocs/streamed_map_bloc.dart';
import '../src/blocs/streamed_values_bloc.dart';
import 'screens/streamed_list_page.dart';
import 'screens/streamed_map_page.dart';
import 'screens/streamed_values_page.dart';

class HomePage extends StatelessWidget {
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
        title: const Text('Frideos examples'),
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
                    'Examples',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              _tile('StreamedObjects', () {
                Navigator.pop(context);

                final bloc = StreamedValuesBloc();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          bloc: bloc,
                          child: StreamedValuesPage(),
                        ),
                  ),
                );
              }),
              _tile('StreamedList', () {
                Navigator.pop(context);

                final bloc = StreamedListBloc();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          bloc: bloc,
                          child: StreamedListPage(),
                        ),
                  ),
                );
              }),
              _tile('StreamedMap', () {
                Navigator.pop(context);

                final bloc = StreamedMapBloc();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          bloc: bloc,
                          child: StreamedMapPage(),
                        ),
                  ),
                );
              }),
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
