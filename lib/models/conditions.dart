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

class Condition {
  String label;
  String name;
  Operator operator;
  Type type;
  bool checked;
  String? value;

  Condition({
    required this.label,
    required this.name,
    this.operator = Operator.equal,
    this.type = Type.string,
    this.checked = false,
    this.value,
  });
}

class Conditions<Node> extends ListBase<Node> {
  final List<Node> _conditions = [];

  @override
  set length(int length) {
    _conditions.length = length;
  }

  @override
  int get length => _conditions.length;

  @override
  void operator []= (int index, Node value) {
    _conditions[index] = value;
  }

  @override
  Node operator [] (int index) => _conditions[index];

  void check(int index) {
    List<Condition> list = cast<Condition>();
    for (Condition condition in list) {
      condition.checked = false;
    }
    list[index].checked = true;
  }
}