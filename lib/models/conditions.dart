import 'dart:collection';

enum Operator {
  start,
  contain
}

enum Type {
  string,
  number,
  date,
}

class Condition {
  String name;
  Operator operator;
  Type type;
  String? value;

  Condition({
    required this.name,
    this.operator = Operator.start,
    this.type = Type.string,
    this.value,
  });
}

class Conditions<Condition> extends ListBase<Condition> {
  final List<Condition> _conditions = [];

  Conditions();

  @override
  set length(int length) {
    _conditions.length = length;
  }

  @override
  int get length => _conditions.length;

  @override
  void operator []= (int index, Condition value) {
    _conditions[index] = value;
  }

  @override
  Condition operator [] (int index) => _conditions[index];
}