import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
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
      case Type.date:
        child = InputDateWidget(focus: node, condition: condition);
        break;
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
          searchBar.state();
        });
  }
}

class InputDateWidget extends StatelessWidget {
  InputDateWidget({
    Key? key,
    required this.focus,
    required this.condition,
  }) : super(key: key);

  final FocusNode focus;
  final ConditionModel condition;

  final searchBar = Get.put(SearchBarController());

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            focusNode: focus,
            //initialValue: '',
            controller: controller,
            style: const TextStyle(fontSize: 20),
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: condition.label,
            ),
            onTap: () async {
              DateTime? date = await showDatePicker(
                locale: const Locale('es', 'AR'),
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(2101)
              );
              if (date != null) {
                condition.value = '${date.millisecondsSinceEpoch}';
                controller.text = '';
                print(condition);
                searchBar.state();
              }
              //} else {
              //  print('Date is not selected');
              //}
            },
            //onChanged: (value) {
            //  condition.value = value;
            //  searchBar.state();
            //}
          ),
        ),
        const Icon(Icons.date_range),
      ],
    );
  }
}

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
  late bool value = widget.condition.value == 'true';

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
        widget.condition.value = '${value}';
        setState(() {});
      },
    );
  }
}