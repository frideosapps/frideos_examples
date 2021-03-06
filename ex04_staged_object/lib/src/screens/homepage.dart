import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../appstate.dart';
import 'page_one.dart';
import 'page_two.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppState appstate = AppStateProvider.of(context);

    final width = MediaQuery.of(context).size.width * 0.7;
    final height = MediaQuery.of(context).size.height * 0.6;

    Widget _background(MaterialColor color) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.5, 1.0],
            colors: [
              color[900],
              color[600],
              color[300],
            ],
          ),
        ),
      );
    }

    final backgrounds = [
      _background(Colors.blue),
      _background(Colors.pink),
      _background(Colors.blueGrey),
      _background(Colors.orange),
    ];

    final stagesMap = <int, Stage>{
      0: Stage(
          widget: Container(
            width: width,
            height: height,
            color: Colors.blue[100],
            alignment: Alignment.center,
            key: const Key('0'),
            child: ScrollingText(
                text:
                    'This stage will last 7 seconds. By the onShow call back it is possibile to assign an action when the widget shows.',
                scrollingDuration: 3000,
                style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
          ),
          time: 7000,
          onShow: () {}),
      1: Stage(
          widget: Container(
            width: width,
            height: height,
            color: Colors.orange[200],
            alignment: Alignment.center,
            key: const Key('1'),
            child: ScrollingText(
              text: 'The next widgets will cross fade.',
              scrollingDuration: 2000,
              style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          time: 8000,
          onShow: () {}),
      2: Stage(
          widget: Container(
              key: const Key('2'),
              child: LinearTransition(
                firstWidget: backgrounds[0],
                secondWidget: backgrounds[1],
                transitionDuration: 4000,
              )),
          time: 5000,
          onShow: () {}),
      3: Stage(
          widget: Container(
              key: const Key('3'),
              child: CurvedTransition(
                firstWidget: backgrounds[2],
                secondWidget: backgrounds[3],
                transitionDuration: 4000,
                curve: Curves.bounceOut,
              )),
          time: 5000,
          onShow: () {}),
      4: Stage(
          widget: Container(
              key: const Key('4'),
              child: LinearTransition(
                firstWidget: backgrounds[1],
                secondWidget: backgrounds[2],
                transitionDuration: 4000,
              )),
          time: 5000,
          onShow: () {}),
      5: Stage(
          widget: Container(
              key: const Key('5'),
              child: CurvedTransition(
                firstWidget: backgrounds[3],
                secondWidget: backgrounds[0],
                transitionDuration: 4000,
                curve: Curves.bounceInOut,
              )),
          time: 5000,
          onShow: () {}),
      6: Stage(
          widget: Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            key: const Key('6'),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                      'Choose the widget to stage in the page one and play the StagedObject in page two.',
                      style: TextStyle(
                          color: Colors.blueGrey[900],
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ),
                Expanded(
                  child: Transform.scale(
                    scale: 1,
                    child: StagedPageOne(
                      bloc: appstate.blocA,
                    ),
                  ),
                ),
              ],
            ),
          ),
          time: 10000,
          onShow: () {}),
    };

    // Setting the map in the build method
    appstate.setMap(stagesMap);

    return Scaffold(
      appBar: AppBar(
        title: const Text('StagedObject'),
      ),
      body: Container(
        color: Colors.blueGrey[50],
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                      color: Colors.lightBlueAccent,
                      child: const Text('Page one'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StagedPageOne(
                                  bloc: appstate.blocA,
                                ),
                          ),
                        );
                      }),
                ),
                Container(width: 40),
                Expanded(
                  child: RaisedButton(
                      color: Colors.lightBlueAccent,
                      child: const Text('Page two'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StagedPageTwo(
                                  bloc: appstate.blocB,
                                ),
                          ),
                        );
                      }),
                ),
              ],
            ),
            Container(
              height: 16,
            ),
            ValueBuilder<StageStatus>(
                streamed: appstate.staged.getStatus,
                builder: (context, snapshot) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        snapshot.data == StageStatus.active
                            ? Container()
                            : Container(
                                color: Colors.yellow,
                                alignment: Alignment.center,
                                height: 32,
                                child: const Text(
                                    'Click on start to show the widgets staged animation.')),
                      ]);
                }),
            Container(
              height: 16,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: SizedBox(
                  width: width,
                  height: height,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: ReceiverWidget(
                      stream: appstate.staged.outStream,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 16,
            ),
            Center(
                child: ValueBuilder(
                    streamed: appstate.text,
                    builder: (context, snapshot) => Text(snapshot.data))),
            SizedBox(
              height: 80,
              width: 80,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: ValueBuilder(
                    streamed: appstate.widget,
                    builder: (context, snapshot) => snapshot.data,
                  ),
                ),
              ),
            ),
            ValueBuilder<StageStatus>(
              streamed: appstate.staged.getStatus,
              builder: (context, snapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    snapshot.data == StageStatus.active
                        ? RaisedButton(
                            color: Colors.lightBlueAccent,
                            child: const Text('Reset'),
                            onPressed: appstate.staged.resetStages,
                          )
                        : Container(),
                    snapshot.data == StageStatus.stop
                        ? RaisedButton(
                            color: Colors.lightBlueAccent,
                            child: const Text('Start'),
                            onPressed: appstate.start)
                        : Container(),
                    snapshot.data == StageStatus.active
                        ? RaisedButton(
                            color: Colors.lightBlueAccent,
                            child: const Text('Stop'),
                            onPressed: appstate.staged.stopStages,
                          )
                        : Container(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
