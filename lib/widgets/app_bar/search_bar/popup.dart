import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class SearchBarPopupWidget extends StatelessWidget {
  final _searchBar = Get.put(SearchBarController());

  SearchBarPopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
          ...List.generate(_searchBar.conditions.length, (index) {
            return _popupMenuItem(index, _searchBar.conditions[index].checked
              ? Icons.radio_button_checked : Icons.radio_button_off,
              _searchBar.conditions[index].label
            );
          }).toList(),
          if (_searchBar.rows.value < _searchBar.conditions.length - 1)
            _popupMenuItem(-1, Icons.add, 'New condition'),
        ];
      }
    );
  }

  PopupMenuItem<int> _popupMenuItem(int index, IconData icon, String label) {
    final _searchBar = Get.put(SearchBarController());

    return PopupMenuItem(
      value: index,
      onTap: () {
        if (index == -1) {
          _searchBar.rows.value++;
        } else {
          _searchBar.conditions.check(index);
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