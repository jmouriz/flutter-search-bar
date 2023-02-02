import 'package:get/get.dart';
import 'package:toolbar/providers/providers.dart';
import 'package:toolbar/models/models.dart';

class SidenavController extends GetxController {
  RxBool open = false.obs;
  RxInt selected = 0.obs;
  ItemsModel items = ItemsProvider().items;

  SidenavController() {
    selected.listen((value) {
      print('option changed sidenav');
    });
  }
}