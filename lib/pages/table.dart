import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/models/models.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final toolbar = Get.put(ToolbarController());
    final searchBar = Get.put(SearchBarController());

    toolbar.title.value = 'Search Test';
    toolbar.search.value = true;
    searchBar.conditions.clear();
    searchBar.conditions.addAll({
      'date': ConditionModel(
        label: 'Date',
        name: 'date',
        type: Type.date,
      ),
      'email': ConditionModel(
        label: 'Email',
        name: 'email',
        operator: Operator.contain,
      ),
      'min-amount': ConditionModel(
        label: 'Min Amount',
        name: 'amount',
        operator: Operator.greater,
      ),
      'max-amount': ConditionModel(
        label: 'Max Amount',
        name: 'amount',
        operator: Operator.less,
      ),
      'checked': ConditionModel(
        label: 'Checked',
        name: 'chacked',
        type: Type.boolean,
      ),
    });

    return const Center(
      child: Text(
        'Data Table',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w900,
        )
      )
    );
  }
}
