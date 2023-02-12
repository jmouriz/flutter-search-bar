import 'package:flutter/material.dart';
import 'package:toolbar/widgets/app_bar/search_bar/input/input.dart';
import 'package:toolbar/models/models.dart';
import 'package:toolbar/types/types.dart';

class SearchBarInputWidget extends StatelessWidget {
  SearchBarInputWidget({required this.condition, super.key});

  final ConditionModel condition;
  final FocusNode node = FocusNode();

  @override
  Widget build(BuildContext context) {
    late final Widget child;
    bool focus = false;

    switch (condition.type) {
      case Type.date:
        child = InputDateWidget(focus: node, condition: condition);
        break;
      case Type.boolean:
        child = InputBooleanWidget(focus: node, condition: condition);
        break;
      case Type.email:
        // TODO
      case Type.list:
        // TODO
      case Type.number:
        // TODO
      default:
        focus = true;
        child = InputStringWidget(focus: node, condition: condition);
    }

    if (focus) {
      Future.delayed(Duration.zero, () {
        node.requestFocus();
      });
    }

    return Container(
      color: Colors.white,
      child: child,
    );
  }
}