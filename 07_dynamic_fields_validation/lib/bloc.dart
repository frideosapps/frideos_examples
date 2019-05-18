import 'package:frideos_core/frideos_core.dart';

class DynamicFieldsBloc {
  DynamicFieldsBloc() {
    print('-------DynamicFields BLOC--------');

    // Adding the initial three pairs of fields to the screen
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

  // A StreamedList holds a list of StreamedValue of type String so
  // it is possibile to add more items.
  final nameFields = StreamedList<StreamedValue<String>>(initialData: []);
  final ageFields = StreamedList<StreamedValue<String>>(initialData: []);

  // This StreamedValue is used to handle the current validation state
  // of the form.
  final isFormValid = StreamedValue<bool>();

  // Every time the user clicks on the "New fields" button, this method
  // adds two new fields and sets the checkForm method to be called
  // every time these new fields change.
  void newFields() {
    nameFields.addElement(StreamedValue<String>());
    ageFields.addElement(StreamedValue<String>());

    nameFields.value.last.onChange(checkForm);
    ageFields.value.last.onChange(checkForm);

    // This is used to force the checking of the form so that, adding
    // the new fields, it can reveal them as empty and sets the form
    // to not valid.
    checkForm(null);
  }

  void checkForm(String _) {
    // These two boolean flags will be used to determine whether each group of fields
    // (name or age) is valid or not.
    bool isValidFieldsTypeName = true;
    bool isValidFieldsTypeAge = true;

    // Checking each name fields: if an item is empty an error will be
    // sent to stream and the `isValidFieldsTypeName` set to false. Instead,
    // if the item is null (e.g when new fields are added),
    // it only sets the `isValidFieldsTypeName` to null in order to disable
    // the submit button.
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

    // Similarly to the previous check, for the age fields is checked
    // even if the value is a number between 1 and 130.
    for (var item in ageFields.value) {
      if (item.value != null) {
        final age = int.tryParse(item.value);

        if (age == null) {
          item.stream.sink.addError('Enter a valid number.');
          isValidFieldsTypeAge = false;
        } else if (age < 1 || age > 130) {
          item.stream.sink
              .addError('The age must be a number between 1 and 130.');
          isValidFieldsTypeAge = false;
        }
      } else {
        isValidFieldsTypeAge = false;
      }
    }

    // If both of each groups are valid it is given a true value
    // to isFormValid (StreamedValue<bool>) sending the true event
    // to the stream triggering the StreamBuilder to rebuild and
    // enable the submit button. If the condition is not met, then
    // a null value is sent to the stream and the button will be
    // disabled.
    if (isValidFieldsTypeName && isValidFieldsTypeAge) {
      isFormValid.value = true;
    } else {
      isFormValid.value = null;
    }
  }

  Map submit() {
    final users = {};

    for (int i = 0; i < nameFields.length; i++) {
      users[i] = {
        'name': nameFields.value[i].value,
        'age': ageFields.value[i].value
      };
    }

    users.forEach((k, v) =>
        print('User ${k + 1} - Name: ${v['name']}, age: ${v['age']}'));

    return users;
  }

  void removeFields(int index) {
    nameFields.removeAt(index);
    ageFields.removeAt(index);
  }

  void dispose() {
    print('-------DynamicFields BLOC DISPOSE--------');

    for (var item in nameFields.value) {
      item.dispose();
    }
    nameFields.dispose();

    for (var item in ageFields.value) {
      item.dispose();
    }
    ageFields.dispose();

    isFormValid.dispose();
  }
}

final bloc = DynamicFieldsBloc();
