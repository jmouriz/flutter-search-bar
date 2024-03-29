import 'dart:collection';
import 'package:intl/intl.dart';
import 'package:toolbar/types/types.dart';

class ConditionModel {
  String label;
  String name;
  Operator operator;
  Type type;
  bool checked;
  Map<int, String>? values;
  String? value;

  ConditionModel({
    required this.label,
    required this.name,
    this.operator = Operator.equal,
    this.type = Type.string,
    this.checked = false,
    this.values,
    this.value,
  });

  @override
  String toString() {
    if (value != null) {
      switch (type) {
        case Type.date:
          DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(value!));
          return DateFormat('dd/MM/yyyy').format(date);
        default:
          return value!;
      }
    }
    return '';
  }

  Map? toJson() {
    if (value != null) {
      return {
        'type': type.name,
        'operator': operator.index,
        'value': value 
      };
    }
    return null;
  }
}

class ConditionsModel extends MapBase<String, ConditionModel> {
  Map<String, ConditionModel> _conditions = {};

  ConditionsModel({conditions}) {
    if (conditions != null) {
      _conditions = conditions;
    }
  }

  @override
  Iterable<String> get keys => _conditions.keys;

  @override
  ConditionModel? remove(key) => _conditions.remove(key);

  @override
  void clear() => _conditions.clear();

  @override
  void operator []= (String key, ConditionModel value) =>
    _conditions[key] = value;

  @override
  ConditionModel? operator [] (key) => _conditions[key];

  @override
  int get length => _conditions.length;

  void check(String key) {
    Map<String, ConditionModel> map = cast<String, ConditionModel>();
    if (map.containsKey(key)) {
      map.forEach((each, value) {
        value.checked = each == key;
      });
    } // else { }
  }
}