import 'package:get/get.dart';
import 'package:toolbar/providers/providers.dart';
import 'package:toolbar/models/models.dart';

class BottomSheetController extends GetxController {
  RxBool open = false.obs;
  ItemsModel items = ItemsProvider().items;

  void close() => open.value = false;
}