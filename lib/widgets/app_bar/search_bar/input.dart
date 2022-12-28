import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class SearchBarInputWidget extends StatelessWidget {
  SearchBarInputWidget({
    this.index,
    super.key
  });

  final index;
  final _searchBar = Get.put(SearchBarController());
  final FocusNode focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    int _index = index + 1;

    if (index == _searchBar.rows.value - 1) {
    Future.delayed(Duration.zero, () {
        focus.requestFocus();
    });
    }

    return Container(
      color: Colors.white,
      child: TextFormField(
        //autofocus: true,
        focusNode: focus,
        initialValue: _searchBar.conditions[_index].value,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: _searchBar.conditions[_index].label,
        ),
      ),
    );
  }
}
