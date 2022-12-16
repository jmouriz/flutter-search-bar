import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/models/models.dart';
import 'package:toolbar/pages/pages.dart';

class SidenavController extends GetxController {
  RxBool open = false.obs;
  RxInt selected = 0.obs;
  Items items = Items();

  SidenavController() {
    items.add(Item(
      title: 'Home',
      icon: Icons.home,
      target: const HomeWidget()
    ));
    items.add(Item(
      title: 'Test data table',
      icon: Icons.list,
      target: const TableWidget()
    ));
  }
}