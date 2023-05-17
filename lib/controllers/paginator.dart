import 'package:get/get.dart';

class PaginatorController extends GetxController {
  RxInt page = 1.obs;
  RxInt rows = 10.obs;
  RxInt count = 1000.obs;

  // PaginatorController() {
  //   rows.listen((value) {
  //     debugPrint('rows changed paginator');
  //   });
  // }

  void first() => page.value = 1;
  void next() => page.value++;
  void previous() => page.value--;
  void last() => page.value = (count.value / rows.value).floor();

}