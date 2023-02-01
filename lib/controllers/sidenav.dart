import 'package:get/get.dart';
import 'package:toolbar/providers/providers.dart';
import 'package:toolbar/models/models.dart';
import 'package:toolbar/controllers/controllers.dart';

class SidenavController extends GetxController {
  RxBool open = false.obs;
  RxInt selected = 0.obs;
  ItemsModel items = ItemsProvider().items;
  final toolbar = Get.put(ToolbarController());

  SidenavController() {
    selected.listen((value) {
      toolbar.search.value = false;
      print('option changed');
    });
  }
}