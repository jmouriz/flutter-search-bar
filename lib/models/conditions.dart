import 'dart:collection';
import 'dart:ffi';

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
  boolean,
}

class ConditionModel {
  String label;
  String name;
  Operator operator;
  Type type;
  bool checked;
  String? value;

  ConditionModel({
    required this.label,
    required this.name,
    this.operator = Operator.equal,
    this.type = Type.string,
    this.checked = false,
    this.value,
  });
}

/*
class ConditionModel<Node> extends ListBase<Node> {
  final List<Node> _conditions = [];

  //@override
  //set length(int length) {
  //  _conditions.length = length;
  //}

  @override
  set length(int length) => _conditions.length = length;

  @override
  int get length => _conditions.length;

  //@override
  //void operator []= (int index, Node value) {
  //  _conditions[index] = value;
  //}

  @override
  void operator []= (int index, Node value) => _conditions[index] = value;

  @override
  Node operator [] (int index) => _conditions[index];

  void check(int index) {
    List<ConditionModel> list = cast<ConditionModel>();
    for (ConditionModel condition in list) {
      condition.checked = false;
    }
    list[index].checked = true;
  }
}
*/

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
      //for (String each in map.keys) {
      //  map[each]!.checked = each == key;
      //}
    } // else { }
  }
}