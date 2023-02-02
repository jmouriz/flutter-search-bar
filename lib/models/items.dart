import 'dart:collection';
import 'package:flutter/material.dart';

class ItemModel {
  String title;
  IconData icon;
  Widget? target;
  ItemsModel? items;
  bool expended;
  bool visible;
  int? badge;
  Function? callback;

  ItemModel({
    required this.title,
    required this.icon,
    this.target,
    this.items,
    this.expended = false,
    this.visible = true,
    this.badge,
    this.callback,
  });
}

class ItemsModel<ItemModel> extends ListBase<ItemModel> {
  final List<ItemModel> _items = [];

  ItemsModel();

  @override
  set length(int length) {
    _items.length = length;
  }

  @override
  int get length => _items.length;

  @override
  void operator []= (int index, ItemModel value) {
    _items[index] = value;
  }

  @override
  ItemModel operator [] (int index) => _items[index];
}