import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/models/models.dart';
import 'package:toolbar/controllers/controllers.dart';

class InputBooleanWidget extends StatefulWidget {
  const InputBooleanWidget({
    Key? key,
    required this.condition,
  }) : super(key: key);

  final ConditionModel condition;

  @override
  State<InputBooleanWidget> createState() => _InputBooleanWidgetState();
}

class _InputBooleanWidgetState extends State<InputBooleanWidget> {
  late bool value = '${widget.condition}' == 'true';
  final searchBar = Get.put(SearchBarController());

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
        print('${widget.condition}');
        searchBar.state();
        setState(() {});
      },
    );
  }
}