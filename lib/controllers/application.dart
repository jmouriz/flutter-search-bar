import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/providers/providers.dart';

class ApplicationController extends GetxController {
  final String version = '1.0';
  final alert = Get.put(AlertController());
  final appBar = Get.put(AppBarController());
  final toolbar = Get.put(ToolbarController());
  final searchBar = Get.put(SearchBarController());
  final sidenav = Get.put(SidenavController());
  final bottomSheet = Get.put(BottomSheetController());
  final dialog = Get.put(DialogController());
  RxBool notch = false.obs;

  ApplicationController() {
    sidenav.open.listen((value) {
      alert.close();
      bottomSheet.close();
      dialog.close();
    });
    sidenav.selected.listen((value) {
      toolbar.reset();
      alert.close();
      bottomSheet.close();
      notch.value = false;
    });
    appBar.searching.listen((value) {
      if (value && !PlatformDetails().isDesktop) sidenav.close();
    });
  }

  set title(value) => toolbar.title.value = value;
  set search(value) => toolbar.search.value = value;
  set busy(value) => toolbar.busy.value = value;
  set next(value) => toolbar.next = value;
  set done(value) => toolbar.done = value;
  set add(value) => toolbar.add = value;
  set valid(value) => toolbar.valid.value = value;
}