import 'package:flutter/material.dart';
import 'package:toolbar/models/models.dart';

class InputBooleanWidget extends StatefulWidget {
  const InputBooleanWidget({
    Key? key,
    required this.focus,
    required this.condition,
  }) : super(key: key);

  final FocusNode focus;
  final ConditionModel condition;

  @override
  State<InputBooleanWidget> createState() => _InputBooleanWidgetState();
}

class _InputBooleanWidgetState extends State<InputBooleanWidget> {
  late bool value = '${widget.condition}' == 'true';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: value ? Colors.green : Colors.red,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.condition.label,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(
                value ? Icons.done : Icons.close,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        value = !value;
        widget.condition.value = '$value';
        setState(() {});
      },
    );
  }
}