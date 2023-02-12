import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:toolbar/providers/providers.dart';
import 'package:toolbar/models/models.dart';

class SidenavController extends GetxController {
  RxBool open = false.obs;
  RxInt selected = 0.obs;
  ItemsModel items = ItemsProvider().items;

  SidenavController() {
    selected.listen((value) {
      debugPrint('option changed sidenav');
    });
  }

  void close() => open.value = false;
}