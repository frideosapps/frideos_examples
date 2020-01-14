import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../appstate.dart';

import 'page_one.dart';
import 'page_two.dart';
import 'page_three.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppState bloc = AppStateProvider.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Multiple selection'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.lightBlueAccent,
                    child: const Text('Page one'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultipleSelectionPageOne(
                                bloc: bloc.blocA,
                              ),
                        ),
                      );
                    },
                  ),
                  RaisedButton(
                    color: Colors.lightBlueAccent,
                    child: const Text('Page two'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultipleSelectionPageTwo(
                                bloc: bloc.blocB,
                              ),
                        ),
                      );
                    },
                  ),
                  RaisedButton(
                    color: Colors.lightBlueAccent,
                    child: const Text('Page three'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultipleSelectionPageThree(
                                bloc: bloc.blocC,
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      'Selected items in page one: ${bloc.blocA.selectedCollection.value.length}'),
                  Text(
                      'Items sent from page one to page two: ${bloc.blocB.items.value.length}'),
                  Text(
                      'Items sent from page one to page three: ${bloc.blocC.items.value.length}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
