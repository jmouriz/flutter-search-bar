import 'package:flutter/material.dart';
import 'package:toolbar/widgets/app_bar/search_bar/input/input.dart';
import 'package:toolbar/models/models.dart';
import 'package:toolbar/types/types.dart';

class SearchBarInputWidget extends StatelessWidget {
  const SearchBarInputWidget({
    super.key,
    required this.condition,
  });

  final ConditionModel condition;

  @override
  Widget build(BuildContext context) {
    late final Widget child;

    switch (condition.type) {
      case Type.date:
        child = InputDateWidget(condition: condition);
        break;
      case Type.boolean:
        child = InputBooleanWidget(condition: condition);
        break;
      case Type.email:
        // TODO
      case Type.list:
        // TODO
      case Type.number:
        // TODO
      default:
        child = InputStringWidget(condition: condition);
    }

    return Container(
      color: Colors.white,
      child: child,
    );
  }
}