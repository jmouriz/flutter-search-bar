import 'package:get/get.dart';

class ToolbarController extends GetxController {
  RxString title = ''.obs;
  RxBool search = false.obs;
  RxBool valid = false.obs;
  void Function()? next;
  void Function()? done;
  void Function()? add;

  void reset() {
    search.value = false;
    valid.value = false;
    next = null;
    done = null;
    add = null;
  }
}