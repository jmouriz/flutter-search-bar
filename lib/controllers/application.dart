import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class ApplicationController extends GetxController {
  final String version = '1.0';
  final alert = Get.put(AlertController());
  final toolbar = Get.put(ToolbarController());
  final sidenav = Get.put(SidenavController());
  final searchBar = Get.put(SearchBarController());
  final bottomSheet = Get.put(BottomSheetController());

  ApplicationController() {
    sidenav.open.listen((value) {
      alert.close();
      bottomSheet.close();
    });
    sidenav.selected.listen((value) {
      search = false;
      alert.close();
      bottomSheet.close();
    });
  }

  set title(value) => toolbar.title.value = value;
  set search(value) => toolbar.search.value = value;
}