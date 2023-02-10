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

// class ItemsModel extends DelegatingList<ItemModel> {
//   final List<ItemModel> items = [];
//   List<ItemModel> get delegate => items;
// }

//extension ItemsModel<ItemModel> on List<ItemModel> {}

class ItemsModel<ItemModel> extends ListBase<ItemModel> {
  // final List<ItemModel> items = [];
  List<ItemModel> _items = [];

  ItemsModel({items}) {
    if (items != null) {
      _items = items;
    }
  }

  @override
  set length(int length) => _items.length = length;

  @override
  int get length => _items.length;

  @override
  void operator []= (int index, ItemModel value) => _items[index] = value;

  @override
  ItemModel operator [] (int index) => _items[index];
}