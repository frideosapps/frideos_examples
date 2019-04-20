import 'package:flutter/material.dart';

import 'package:frideos_core/frideos_core.dart';

import 'package:frideos/frideos.dart';

import '../blocs/bloc.dart';
import '../blocs/dynamic_fields_validation_bloc.dart';
import '../styles.dart';

class DynamicFieldsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dynamic fields validation'),
        ),
        body: DynamicFieldsWidget(),
      ),
    );
  }
}

class FieldsWidget extends StatelessWidget {
  const FieldsWidget({
    this.index,
    this.nameController,
    this.ageController,
  });

  final int index;
  final TextEditingController nameController;
  final TextEditingController ageController;

  @override
  Widget build(BuildContext context) {
    final DynamicFieldsBloc bloc = BlocProvider.of(context);

    return Row(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text('${index + 1}:')),
        Expanded(
          child: Column(
            children: <Widget>[
              StreamBuilder<String>(
                  initialData: ' ',
                  stream: bloc.nameFields.value[index].outStream,
                  builder: (context, snapshot) {
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: TextField(
                            controller: nameController,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Name:',
                              hintText: 'Insert a name...',
                              errorText: snapshot.error,
                            ),
                            onChanged: bloc.nameFields.value[index].inStream,
                          ),
                        ),
                      ],
                    );
                  }),
              StreamBuilder<String>(
                  initialData: ' ',
                  stream: bloc.ageFields.value[index].outStream,
                  builder: (context, snapshot) {
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: TextField(
                            controller: ageController,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Age:',
                              hintText: 'Insert the age (1 - 999).',
                              errorText: snapshot.error,
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: bloc.ageFields.value[index].inStream,
                          ),
                        ),
                      ],
                    );
                  }),
              const SizedBox(
                height: 22.0,
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          color: Colors.red,
          onPressed: () => bloc.removeFields(index),
        ),
      ],
    );
  }
}

class DynamicFieldsWidget extends StatelessWidget {
  final nameFieldsController = List<TextEditingController>();
  final ageFieldsController = List<TextEditingController>();

  @override
  Widget build(BuildContext context) {
    final DynamicFieldsBloc bloc = BlocProvider.of(context);

    List<Widget> _buildForm(int length) {
      // Clear TextEditingController lists
      nameFieldsController.clear();
      ageFieldsController.clear();

      for (int i = 0; i < length; i++) {
        final name = bloc.nameFields.value[i].value;
        final age = bloc.ageFields.value[i].value;

        nameFieldsController.add(TextEditingController(text: name));
        ageFieldsController.add(TextEditingController(text: age));
      }

      return List<Widget>.generate(
          length,
          (i) => FieldsWidget(
                index: i,
                nameController: nameFieldsController[i],
                ageController: ageFieldsController[i],
              ));
    }

    return ListView(
      children: <Widget>[
        Container(
          height: 16.0,
        ),
        ValueBuilder<List<StreamedValue<String>>>(
          streamed: bloc.nameFields,
          builder: (context, snapshot) {
            return Column(
              children: _buildForm(snapshot.data.length),
            );
          },
          noDataChild: const Text('NO DATA'),
        ),
        Container(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
              color: Colors.green,
              child: const Text('Add more fields', style: buttonText),
              onPressed: bloc.newFields,
            ),
            StreamBuilder<bool>(
                stream: bloc.isFormValid.outStream,
                builder: (context, snapshot) {
                  return RaisedButton(
                    color: Colors.blue,
                    child: snapshot.hasData
                        ? snapshot.data
                            ? const Text('Submit', style: buttonText)
                            : const Text('Form not valid', style: buttonText)
                        : const Text('Form not valid', style: buttonText),
                    onPressed: snapshot.hasData ? bloc.submit : null,
                  );
                }),
          ],
        ),
      ],
    );
  }
}
