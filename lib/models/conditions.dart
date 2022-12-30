import 'dart:collection';

enum Operator {
  start,
  contain,
  equal,
  less,
  greater,
}

enum Type {
  string,
  number,
  date,
  list,
  boolean,
}

class ConditionModel {
  String label;
  String name;
  Operator operator;
  Type type;
  bool checked;
  List<String>? values;
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
    return 'label: "$label", name: $name, type: $type, operator: $operator';
  }
}

class ConditionsModel extends MapBase<String, ConditionModel> {
  final Map<String, ConditionModel> _conditions = {};

  @override
  Iterable<String> get keys => _conditions.keys;

  @override
  ConditionModel? remove(key) => _conditions.remove(key);

  @override
  void clear() => _conditions.clear();

  @override
  void operator []= (String key, ConditionModel value) => _conditions[key] = value;

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