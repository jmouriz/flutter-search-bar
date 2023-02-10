import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:mutable_icon/mutable_icon.dart';

class ItemModel {
  String title;
  IconData icon;
  Widget? target;
  ItemsModel? items;
  bool expanded;
  bool visible;
  int? badge;
  Function? callback;

  final MutableIconController _controller = MutableIconController();

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

  get submenu => items != null;
  get controller => _controller;
}

class ItemsModel<ItemModel> extends ListBase<ItemModel> {
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