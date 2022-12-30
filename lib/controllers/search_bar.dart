import 'package:get/get.dart';
import 'package:toolbar/models/models.dart';

class SearchBarController extends GetxController {
  RxInt rows = 0.obs;
  ConditionsModel conditions = ConditionsModel();
  List<String> entries = [];
  Function setState = () {};

  void init() {
    entries = [];
    conditions.forEach((key, value) {
      value.checked = false;
    });
    addCondition();
  }

  ConditionModel? addCondition() {
    for (String key in conditions.keys) {
      if (!conditions[key]!.checked) {
        conditions[key]!.checked = true;
        entries.add(key);
        return conditions[key];
      }
    }
    return null;
  }

  void deleteCondition(int index) {
    conditions[entries[index]]!.checked = false;
    entries.removeAt(index);
  }

  ConditionModel? getCondition(int index) {
    return conditions[entries[index]!];
  }

  void checkCondition(int index, String key) {
    conditions[entries[index]]!.checked = false;
    entries[index] = key;
    conditions[key]!.checked = true;
    setState(() {});
  }
}