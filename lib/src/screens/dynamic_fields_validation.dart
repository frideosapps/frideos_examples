import 'package:flutter/material.dart';

import 'package:frideos_core/frideos_core.dart';

import 'package:frideos/frideos.dart';

import '../blocs/bloc.dart';
import '../blocs/dynamic_fields_validation_bloc.dart';

const TextStyle styleHeader =
    TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500);
const TextStyle styleValue =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
const TextStyle styleOldValue =
    TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500);
const double padding = 22;
const Color buttonColor = Color(0xff99cef9);

class DynamicFieldsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dynamic fields'),
        ),
        body: DynamicFieldsWidget(),
      ),
    );
  }
}

class DynamicFieldsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DynamicFieldsBloc bloc = BlocProvider.of(context);

    List<Widget> _buildFields(int length) {
      var fields = List<Widget>();

      for (int i = 0; i < length; i++) {
        fields.add(StreamBuilder<String>(
            initialData: ' ',
            stream: bloc.nameFields.value[i].outStream,
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
                        labelText: 'Name:',
                        hintText: 'Insert a text...',
                        errorText: snapshot.error,
                      ),
                      onChanged: bloc.nameFields.value[i].inStream,
                    ),
                  ),
                ],
              );
            }));

        fields.add(
          StreamBuilder<String>(
              initialData: ' ',
              stream: bloc.ageFields.value[i].outStream,
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
                          labelText: 'Age:',
                          hintText: 'Insert the age (1 - 999).',
                          errorText: snapshot.error,
                        ),
                        onChanged: bloc.ageFields.value[i].inStream,
                      ),
                    ),
                  ],
                );
              }),
        );
      }
      return fields;
    }

    return ListView(
      children: <Widget>[
        StreamBuilder<bool>(
            stream: bloc.isFormValid.outStream,
            builder: (context, snapshot) {
              return RaisedButton(
                color: buttonColor,
                child: snapshot.hasData
                    ? snapshot.data
                        ? const Text('Valid')
                        : const Text('Form not valid')
                    : const Text('Form not valid'),
                onPressed: snapshot.hasData ? bloc.someActions : null,
              );
            }),
        Container(
          height: 16.0,
        ),
        ValueBuilder<List<StreamedValue<String>>>(
          streamed: bloc.nameFields,
          builder: (context, snapshot) {
            return Column(
              children: <Widget>[
                Text('Dynamic fields: ${snapshot.data.length*2}',
                    style: styleHeader),
                Column(
                  children: _buildFields(snapshot.data.length),
                ),
              ],
            );
          },
          noDataChild: const Text('NO DATA'),
        ),
        Container(height: 20),
        RaisedButton(
          color: buttonColor,
          child: const Text('Add fields'),
          onPressed: bloc.newFields,
        ),
      ],
    );
  }
}
