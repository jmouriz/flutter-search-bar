import 'package:get/get.dart';

class AlertController extends GetxController {
  RxBool open = false.obs;
  String _message = '';

  void show({required String message, int? timeout}) {
    _message = message;
    open.value = true;

    if (timeout != null) {
      Future.delayed(Duration(milliseconds: timeout * 1000), () {
        open.value = false;
      });
    }
  }

  get message => _message;
}