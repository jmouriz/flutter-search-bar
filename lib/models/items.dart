import 'dart:collection';
import 'package:flutter/material.dart';

class Item {
  String title;
  IconData icon;
  Widget target;

  Item({
    required this.title,
    required this.icon,
    required this.target,
  });
}

class Items<Item> extends ListBase<Item> {
  final List<Item> _items = [];

  Items();

  @override
  set length(int length) {
    _items.length = length;
  }

  @override
  int get length => _items.length;

  @override
  void operator []= (int index, Item value) {
    _items[index] = value;
  }

  @override
  Item operator [] (int index) => _items[index];
}