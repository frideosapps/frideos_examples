import 'dart:math' as math;

import 'package:frideos_core/frideos_core.dart';

import '../blocs/bloc.dart';

class DynamicFieldsBloc extends BlocBase {
  DynamicFieldsBloc() {
    print('-------DynamicFields BLOC--------');

    // Adding the iniital three pairs of fields to the screen
    nameFields.addAll([
      StreamedValue<String>(initialData: 'Name AA'),
      StreamedValue<String>(initialData: 'Name BB'),
      StreamedValue<String>(initialData: 'Name CC')
    ]);

    ageFields.addAll([
      StreamedValue<String>(initialData: '11'),
      StreamedValue<String>(initialData: '22'),
      StreamedValue<String>(initialData: '33')
    ]);

    // Set the method to call every time the stream emits a new event
    for (var item in nameFields.value) {
      item.onChange(checkForm);
    }

    for (var item in ageFields.value) {
      item.onChange(checkForm);
    }
  }

  // A StreamedList holds the a list of StreamedValue of type String so
  // it is possibile adding more items.
  final nameFields = StreamedList<StreamedValue<String>>(initialData: []);
  final ageFields = StreamedList<StreamedValue<String>>(initialData: []);

  // This StreamedValue is used to handle the current validation state
  // of the form.
  final isFormValid = StreamedValue<bool>();

  // Every time the user clicks on the "New fields" button, this method
  // add two new fields and sets the checkForm method to be called
  // every time these new fields changes.
  void newFields() {
    final name = math.Random().nextInt(99999);
    final age = math.Random().nextInt(120);

    nameFields.addElement(StreamedValue<String>(initialData: 'Name $name'));
    ageFields.addElement(StreamedValue<String>(initialData: '$age'));

    nameFields.value.last.onChange(checkForm);
    ageFields.value.last.onChange(checkForm);

    // This is used to force the checking of the form so that, adding
    // the new fields, it can reveal them as empty and sets the form
    // to not valid.
    checkForm(null);
  }

  void checkForm(String _) {
    bool isValidFieldsTypeName = true;
    bool isValidFieldsTypeAge = true;

    for (var item in nameFields.value) {
      if (item.value != null) {
        if (item.value.isEmpty) {
          item.stream.sink.addError('The text must not be empty.');
          isValidFieldsTypeName = false;
        }
      } else {
        isValidFieldsTypeName = false;
      }
    }

    for (var item in ageFields.value) {
      if (item.value != null) {
        final age = int.tryParse(item.value);

        if (age == null) {
          item.stream.sink.addError('Enter a valida number.');
          isValidFieldsTypeAge = false;
        } else if (age < 1 || age > 999) {
          item.stream.sink
              .addError('The age must be a number between 1 and 999.');
          isValidFieldsTypeAge = false;
        }
      } else {
        isValidFieldsTypeAge = false;
      }
    }

    if (isValidFieldsTypeName && isValidFieldsTypeAge) {
      isFormValid.value = true;
    } else {
      isFormValid.value = null;
    }
  }

  void submit() {
    print('Actions');
  }

  void removeFields(int index) {
    nameFields.removeAt(index);
    ageFields.removeAt(index);
  }

  @override
  void dispose() {
    print('-------DynamicFields BLOC DISPOSE--------');
    nameFields.dispose();
    ageFields.dispose();
    isFormValid.dispose();
  }
}
