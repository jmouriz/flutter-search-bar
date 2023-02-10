import 'package:get/get.dart';

enum AlertType {
  success,
  error,
  warning,
  info,
  normal,
}

class AlertController extends GetxController {
  RxBool open = false.obs;
  String? _title;
  AlertType? _type = AlertType.normal;
  String _message = '';

  void show({
    required String message,
    String? title,
    AlertType? type,
    int? timeout
  }) {
    _title = title;
    _message = message;
    _type = type;
    open.value = true;

    if (timeout != null) {
      Future.delayed(Duration(milliseconds: timeout * 1000), () {
        close();
      });
    }
  }

  void close() => open.value = false;

  get message => _message;
  get title => _title;
  get type => _type;
}