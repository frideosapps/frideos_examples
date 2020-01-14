import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../blocs/bloc_provider.dart';
import '../blocs/streamed_list_bloc.dart';
import '../styles.dart';

class StreamedListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('StreamedList'),
        ),
        body: StreamedListWidget(),
      ),
    );
  }
}

class StreamedListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final StreamedListBloc bloc = BlocProvider.of(context);

    return Column(
      children: <Widget>[
        StreamBuilder<String>(
            initialData: ' ',
            stream: bloc.streamedText.outTransformed,
            builder: (context, snapshot) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                    child: TextField(
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Text:',
                        hintText: 'Insert a text...',
                        errorText: snapshot.error,
                      ),
                      // To avoid the user could insert text use the
                      // TextInputType.number. Here is commented to
                      // show the error msg.
                      // keyboardType: TextInputType.number,
                      onChanged: bloc.streamedText.inStream,
                    ),
                  ),
                  RaisedButton(
                    color: buttonColor,
                    child: const Text('Add text'),
                    onPressed: snapshot.hasData ? bloc.addText : null,
                  ),
                ],
              );
            }),
        Container(height: 20),
        Expanded(
          child: ValueBuilder<List<String>>(
            streamed: bloc.streamedList,
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => Center(
                      child: Text('Value $index: ${snapshot.data[index]}',
                          style: styleValue)));
            },
            noDataChild: const Text('NO DATA'),
          ),
        ),
      ],
    );
  }
}
