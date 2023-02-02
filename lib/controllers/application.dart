import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class ApplicationController extends GetxController {
  final toolbar = Get.put(ToolbarController());
  final sidenav = Get.put(SidenavController());
  final searchBar = Get.put(SearchBarController());
  final bottomSheet = Get.put(BottomSheetController());

  ApplicationController() {
    sidenav.selected.listen((value) {
      search = false;
    });
  }

  set title(value) => toolbar.title.value = value;
  set search(value) => toolbar.search.value = value;
}