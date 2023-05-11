import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:mutable_icon/mutable_icon.dart';

enum Mode {
  expand,
  replace,
}

class ItemModel {
  String title;
  dynamic icon;
  Widget? target;
  ItemsModel? items;
  bool expanded;
  bool visible;
  int? badge;
  bool setted;
  Mode mode;
  Function(ItemModel item, BuildContext context)? callback;
  Function(ItemModel item, BuildContext context)? setup;
  bool Function(ItemModel item) show;

  final MutableIconController _controller = MutableIconController();

  ItemModel({
    required this.title,
    required this.icon,
    this.target,
    this.items,
    this.expanded = false,
    this.visible = true,
    this.badge,
    this.setted = false,
    this.mode = Mode.expand,
    this.callback,
    this.setup,
    this.show = _show,
  });

  get submenu => items != null;
  get controller => _controller;

  static bool _show(item) => true;
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