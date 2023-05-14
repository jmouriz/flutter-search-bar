import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DialogController extends GetxController {
  RxBool open = false.obs;
  Widget? _body;

  void show({
    Widget? body,
  }) {
    _body = body;
    open.value = true;
  }

  void close() => open.value = false;

  get body => _body;
}