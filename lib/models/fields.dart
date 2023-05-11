import 'dart:collection';
//import 'package:toolbar/models/models.dart';

class FieldModel {
  bool valid;
  String name;
  String? value;

  FieldModel({
    this.valid = false,
    required this.name,
    this.value,
  });

  // final ValueModel _value = ValueModel();
  // set value(value) => _value.value = value;
  // get value => _value.value;
  // set type(type) => _value.type = type;
  // get type => _value.type;

  @override
  String toString() {
    if (valid) {
      return value!;
    }
    return '';
  }

  Map? toJson() {
    if (valid) {
      return {
        'name': name,
        'value': value,
      };
    }
    return null;
  } 
}

class FieldsModel<FieldModel> extends ListBase<FieldModel> {
  List<FieldModel> _field = [];

  FieldsModel({field}) {
    if (field != null) {
      _field = field;
    }
  }

  @override
  set length(int length) => _field.length = length;

  @override
  int get length => _field.length;

  @override
  void operator []= (int index, FieldModel value) => _field[index] = value;

  @override
  FieldModel operator [] (int index) => _field[index];
}