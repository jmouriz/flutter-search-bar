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
          _popupMenuItem(0, Icons.radio_button_off, 'Email'),
          _popupMenuItem(0, Icons.radio_button_on, 'Name'),
          _popupMenuItem(0, Icons.radio_button_off, 'Date'),
          _popupMenuItem(0, Icons.add, 'New condition'),
        ];
      }
    );
  }

  PopupMenuItem<int> _popupMenuItem(int value, IconData icon, String label) {
    final _searchBar = Get.put(SearchBarController());

    return PopupMenuItem(
      value: value,
      onTap: () {
        _searchBar.rows.value++;
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