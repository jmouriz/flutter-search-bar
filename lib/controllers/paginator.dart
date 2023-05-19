import 'package:get/get.dart';

class PaginatorController extends GetxController {
  RxInt page = 1.obs;
  RxInt rows = 10.obs;
  RxInt count = 1000.obs;
  bool touched = false;
  
  // PaginatorController() {
  //   rows.listen((value) {
  //     debugPrint('rows changed paginator');
  //   });
  // }

  void first() => page.value = 1;
  void next() => page.value++;
  void previous() => page.value--;
  void last() => page.value = (count.value / rows.value).floor();

  bool get canFirst => page.value > 1;
  bool get canPrevious => page.value > 1;
  bool get canNext => true;
  bool get canLast => true;

  int get from => (page.value - 1) * rows.value;

  int get to {
    int last = (page.value - 1) * rows.value + rows.value;
    return last > count.value ? count.value : last;
  }

}