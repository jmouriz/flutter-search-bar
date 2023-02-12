import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:mutable_icon/mutable_icon.dart';

class FieldModel {
  bool valid;

  FieldModel({
    this.valid = false,
  });
}

class FieldsModel<FieldModel> extends ListBase<FieldModel> {
  List<FieldModel> _field = [];

  FieldsModel({field}) {
    if (field != null) {
      _field = field;
    }
  }

  @override
  set length(int length) => _field.length = length;

  @override
  int get length => _field.length;

  @override
  void operator []= (int index, FieldModel value) => _field[index] = value;

  @override
  FieldModel operator [] (int index) => _field[index];
}