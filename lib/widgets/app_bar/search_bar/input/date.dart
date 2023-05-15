import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/models/models.dart';

class InputDateWidget extends StatelessWidget {
  InputDateWidget({
    Key? key,
    required this.condition,
  }) : super(key: key);

  final ConditionModel condition;

  final searchBar = Get.put(SearchBarController());

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    controller.text = '$condition';

    void tap() async {
      //FocusManager.instance.primaryFocus?.unfocus();
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      DateTime? date;
      await Future.delayed(const Duration(milliseconds: 100), () async {
      //DateTime? date = await showDatePicker(
      //DateTime? date = await showRoundedDatePicker(
        date = await showDatePicker(
          locale: const Locale('es', 'AR'),
          context: context,
          //height: 360,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2101),
          builder: (BuildContext context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                dialogTheme: DialogTheme(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
      });
      if (date != null) {
        condition.value = '${date!.millisecondsSinceEpoch}';
        controller.text = '$condition';
        debugPrint('$condition');
        //searchBar.state();
      }
      //} else {
      //  print('Date is not selected');
      //}
    }

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            //focusNode: focus,
            //initialValue: '$condition',
            controller: controller,
            keyboardType: TextInputType.datetime,
            style: const TextStyle(fontSize: 20),
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: condition.label,
            ),
            //onTap: () => tap(),
          ),
        ),
        IconButton(
          onPressed: () => tap(),
          icon: const Icon(Icons.date_range),
        ),
      ],
    );
  }
}