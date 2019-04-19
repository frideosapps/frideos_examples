import 'dart:async';

import 'package:frideos_core/frideos_core.dart';

import '../blocs/bloc.dart';

class DynamicFieldsBloc extends BlocBase {
  DynamicFieldsBloc() {
    print('-------DynamicFields BLOC--------');

    // Adding the first two fields to the screen
    nameFields.addElement(StreamedValue<String>(initialData: 'Name 1'));
    ageFields.addElement(StreamedValue<String>(initialData: '27'));

    // Set the method to call everytime the stream emits a new event
    nameFields.value.last.onChange(checkForm);
    ageFields.value.last.onChange(checkForm);

    // Adding other fields to the screen
    nameFields.addElement(StreamedValue<String>(initialData: 'Name 2'));
    ageFields.addElement(StreamedValue<String>(initialData: '33'));

    nameFields.value.last.onChange(checkForm);
    ageFields.value.last.onChange(checkForm);
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
    nameFields.addElement(StreamedValue<String>());
    ageFields.addElement(StreamedValue<String>());

    nameFields.value.last.onChange(checkForm);
    ageFields.value.last.onChange(checkForm);

    // This is used to force the check of the form so that, adding
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
