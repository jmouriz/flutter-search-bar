import 'package:flutter/material.dart';
import 'package:toolbar/models/models.dart';

class SearchBarInputWidget extends StatelessWidget {
  SearchBarInputWidget({
    required this.condition,
    super.key
  });

  //final _searchBar = Get.put(SearchBarController());
  final ConditionModel condition;
  final FocusNode focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      focus.requestFocus();
    });

    return condition == null ? const Text('Error') : Container(
      color: Colors.white,
      child: TextFormField(
        focusNode: focus,
        //initialValue: '', // _searchBar.conditions[_index].value,
        initialValue: condition!.value,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          //hintText: 'Search...', // _searchBar.conditions[_index].label,
          hintText: condition!.label,
        ),
      ),
    );
  }
}
