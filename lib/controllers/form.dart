import 'package:get/get.dart';
import 'package:toolbar/models/fields.dart';

class FormController extends GetxController {
  FieldsModel fields = FieldsModel();

  bool valid() {
    bool valid = true;
    for (var field in fields) {
      if (!field.valid) {
        valid = false;
        break;
      }
    }
    return valid;
  }

  void values() {
    print(fields.toString());
    for (var field in fields) {
      print(field.toJson());
    }
  }
}