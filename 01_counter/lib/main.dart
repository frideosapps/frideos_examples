import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import 'package:frideos_core/frideos_core.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Counter Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counter = StreamedValue<int>(initialData: 0);
  final noInitialDataCounter = StreamedValue<int>();

  void _incrementCounter() {
    counter.value++;

    noInitialDataCounter.value ??= 0;
    noInitialDataCounter.value++;
  }

  @override
  void dispose() {
    counter.dispose();
    noInitialDataCounter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('counter:', style: Theme.of(context).textTheme.headline),
            ValueBuilder<int>(
                streamed: counter,
                builder: (context, snapshot) => Text(
                      '${snapshot.data}',
                      style: Theme.of(context).textTheme.display1,
                    )),
            //
            // Using the StreamBuilder:
            //
            // StreamBuilder<int>(
            //    stream: counter.outStream,
            //    builder: (context, snapshot) {
            //      return !snapshot.hasData
            //          ? Container()
            //          : Text(
            //              '${snapshot.data}',
            //              style: Theme.of(context).textTheme.display1,
            //           );
            // }),
            //
            Container(height: 64),
            Text('noInitialDataCounter:',
                style: Theme.of(context).textTheme.headline),
            ValueBuilder<int>(
                streamed: noInitialDataCounter,
                noDataChild: Text('No data'),
                builder: (context, snapshot) => Text(
                      '${snapshot.data}',
                      style: Theme.of(context).textTheme.display1,
                    )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
