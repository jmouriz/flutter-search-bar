import 'dart:collection';
import 'package:flutter/material.dart';

class ItemModel {
  String title;
  IconData icon;
  Widget? target;

  ItemModel({
    required this.title,
    required this.icon,
    this.target,
  });
}

class ItemsModel<ItemModel> extends ListBase<ItemModel> {
  final List<ItemModel> items = [];

  ItemsModel();

  @override
  set length(int length) {
    items.length = length;
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