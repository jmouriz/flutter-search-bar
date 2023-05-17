import 'package:get/get.dart';
import 'package:toolbar/providers/providers.dart';
import 'package:toolbar/models/models.dart';

class DesktopController extends GetxController {
  RxInt selected = 0.obs;
  ItemsModel items = DesktopProvider().items;

  // DesktopController() {
  //   selected.listen((value) {
  //     debugPrint('option changed desktop');
  //   });
  // }
}