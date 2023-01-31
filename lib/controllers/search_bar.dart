import 'package:get/get.dart';
import 'package:toolbar/models/models.dart';

class SearchBarController extends GetxController {
  RxInt rows = 0.obs;
  RxInt version = DateTime.now().millisecondsSinceEpoch.obs;
  //RxInt visibles = 0.obs;
  //int minLength = 3;
  ConditionsModel conditions = ConditionsModel();
  List<String> entries = [];
  Function setState = () {};

  void state() {
    version.value = DateTime.now().millisecondsSinceEpoch;
  }

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
    ConditionModel condition = conditions[entries[index]]!;
    condition.checked = false;
    condition.value = null;
    entries.removeAt(index);
    state();
  }

  ConditionModel? getCondition(int index) {
    return conditions[entries[index]];
  }

  List<ConditionModel> getConditions() {
    List<ConditionModel> result = [];
    conditions.forEach((key, condition) {
      if (condition.checked && condition.value != null) {
        result.add(condition);
      }
    });
    return result;
  }

  void checkCondition(int index, String key) {
    ConditionModel condition = conditions[entries[index]]!;
    condition.checked = false;
    condition.value = null;
    entries[index] = key;
    conditions[key]!.checked = true;
    setState(() {});
  }
}