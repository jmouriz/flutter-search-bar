import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/models/models.dart';

class Relation {
  String key;
  ConditionModel condition;

  Relation({
    required this.key,
    required this.condition,
  });
}

class SearchBarPopupWidget extends StatelessWidget {
  SearchBarPopupWidget({
    required this.index,
    super.key
  });

  final int index;
  final searchBar = Get.put(SearchBarController());

  @override
  Widget build(BuildContext context) {
    final List<Relation> conditions = [];
    searchBar.conditions.forEach((key, value) => conditions.add(Relation(
      key: key,
      condition: value,
    )));

    return PopupMenuButton(
      position: PopupMenuPosition.under,
      tooltip: 'Available conditions',
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0))
      ),
      icon: const Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
      itemBuilder: (_) {
        return [
          ...List.generate(conditions.length, (last) {
            Relation relation = conditions[last];
            return _popupMenuItem(relation.key, relation.condition);
          }).toList(),
          if (searchBar.rows.value < searchBar.conditions.length - 1)
            _popupMenuItem(),
        ];
      }
    );
  }

  PopupMenuItem<int> _popupMenuItem([String? key, ConditionModel? condition]) {
    late final IconData icon;
    late final String label;

    if (condition == null) {
      icon = Icons.add;
      label = 'New condition';
    } else {
      icon = condition.checked
        ? Icons.radio_button_checked
        : Icons.radio_button_off;
      label = condition.label;
    }

    return PopupMenuItem(
      enabled: condition == null || !condition.checked,
      onTap: () {
        if (key == null) {
          searchBar.rows.value++;
          searchBar.addCondition();
        } else {
          searchBar.checkCondition(index, key);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(label),
            ),
          ),
        ],
      ),
    );
  }
}