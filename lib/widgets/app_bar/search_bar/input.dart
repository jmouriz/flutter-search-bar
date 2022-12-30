import 'package:flutter/material.dart';
import 'package:toolbar/models/models.dart';

class SearchBarInputWidget extends StatelessWidget {
  SearchBarInputWidget({required this.condition, super.key});

  final ConditionModel condition;
  final FocusNode node = FocusNode();

  @override
  Widget build(BuildContext context) {
    late final Widget child;
    bool focus = false;

    switch (condition.type) {
      case Type.boolean:
        child = InputBooleanWidget(focus: node, condition: condition);
        break;
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

class InputStringWidget extends StatelessWidget {
  const InputStringWidget({
    Key? key,
    required this.focus,
    required this.condition,
  }) : super(key: key);

  final FocusNode focus;
  final ConditionModel condition;

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
    );
  }
}

class InputBooleanWidget extends StatelessWidget {
  const InputBooleanWidget({
    Key? key,
    required this.focus,
    required this.condition,
  }) : super(key: key);

  final FocusNode focus;
  final ConditionModel condition;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: Colors.red,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(condition.label,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
            const Icon(Icons.check_box_outline_blank,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
