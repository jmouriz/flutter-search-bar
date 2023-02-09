import 'dart:collection';
import 'package:flutter/material.dart';

class ItemModel {
  String title;
  IconData icon;
  Widget? target;
  ItemsModel? items;
  bool expanded;
  bool visible;
  int? badge;
  Function? callback;

  ItemModel({
    required this.title,
    required this.icon,
    this.target,
    this.items,
    this.expanded = false,
    this.visible = true,
    this.badge,
    this.callback,
  });

  bool get submenu => items != null;
}

class ItemsModel<ItemModel> extends ListBase<ItemModel> {
  final List<ItemModel> items = [];

  ItemsModel({
    items,
  });

  @override
  set length(int length) {
    items!.length = length;
  }

  @override
  int get length => items.length;

  @override
  void operator []= (int index, ItemModel value) {
    items[index] = value;
  }

  @override
  ItemModel operator [] (int index) => items[index];
}