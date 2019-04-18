import 'dart:async';

import 'package:frideos_core/frideos_core.dart';

import '../blocs/bloc.dart';

class DynamicFieldsBloc extends BlocBase {
  DynamicFieldsBloc() {
    print('-------DynamicFields BLOC--------');

    nameFields.addElement(StreamedValue<String>());
    ageFields.addElement(StreamedValue<String>());

    nameFields.value.last.onChange(checkForm);
    ageFields.value.last.onChange(checkForm);
  }

  final nameFields = StreamedList<StreamedValue<String>>(initialData: []);
  final ageFields = StreamedList<StreamedValue<String>>(initialData: []);

  final isFormValid = StreamedValue<bool>();

  void newFields() {
    nameFields.addElement(StreamedValue<String>());
    ageFields.addElement(StreamedValue<String>());

    nameFields.value.last.onChange(checkForm);
    ageFields.value.last.onChange(checkForm);

    nameFields.refresh();

    checkForm(null);
  }

  void checkForm(String str) {
    bool isValidFieldsTypeName = true;
    bool isValidFieldsTypeAge = true;

    for (var item in nameFields.value) {
      if (item.value != null) {
        if (item.value == '') {
          item.stream.sink.addError('The text must not be empty.');
          isValidFieldsTypeName = false;
        }
      } else {
        isValidFieldsTypeName = false;
      }
    }

    for (var item in ageFields.value) {
      if (item.value != null) {
        int age = int.tryParse(item.value);

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

  void someActions() {
    print('Actions');
  }

  void dispose() {
    print('-------DynamicFields BLOC DISPOSE--------');
    nameFields.dispose();
    ageFields.dispose();
    isFormValid.dispose();
  }
}
