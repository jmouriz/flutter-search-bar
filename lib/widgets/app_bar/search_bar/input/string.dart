import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/models/models.dart';

class InputStringWidget extends StatelessWidget {
  InputStringWidget({
    Key? key,
    required this.focus,
    required this.condition,
  }) : super(key: key);

  final FocusNode focus;
  final ConditionModel condition;

  final searchBar = Get.put(SearchBarController());

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        focusNode: focus,
        initialValue: condition.value,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: condition.label,
        ),
        onChanged: (value) {
          condition.value = value;
          print(value);
          searchBar.state();
        });
  }
}