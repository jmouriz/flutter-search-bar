import 'package:intl/intl.dart';
import 'package:toolbar/types/types.dart';

class ValueModel {
  Type type;
  String? value;

  ValueModel({
    this.type = Type.string,
    this.value,
  });

  @override
  String toString() {
    if (value != null) {
      switch (type) {
        case Type.date:
          DateTime date =
            DateTime.fromMillisecondsSinceEpoch(int.parse(value!));
          return DateFormat('dd/MM/yyyy').format(date);
        default:
          return value ?? '';
      }
    }
    return '';
  }

  Map? toJson() {
    if (value != null) {
      return {
        'type': type.name,
        'value': value 
      };
    }
    return null;
  }
}