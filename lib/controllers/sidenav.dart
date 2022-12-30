import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/models/models.dart';
import 'package:toolbar/pages/pages.dart';

class SidenavController extends GetxController {
  RxBool open = false.obs;
  RxInt selected = 0.obs;
  ItemsModel items = ItemsModel();

  SidenavController() {
    items.add(ItemModel(
      title: 'Home',
      icon: Icons.home,
      target: const HomeWidget()
    ));
    items.add(ItemModel(
      title: 'Search Test',
      icon: Icons.list,
      target: const TableWidget()
    ));
  }
}