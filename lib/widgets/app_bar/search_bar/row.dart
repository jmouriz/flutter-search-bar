import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/widgets/app_bar/search_bar/search_bar.dart';

class SearchBarRowWidget extends StatelessWidget {
  SearchBarRowWidget({
    required this.index,
    super.key,
  });

  final int index;
  final searchBar = Get.put(SearchBarController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        children: [
          SearchBarPopupWidget(index: index),
          Expanded(
            child: SearchBarInputWidget(condition: searchBar.getCondition(index)!),
          ),
          IconButton(
            icon: const Icon(
              Icons.remove,
              color: Colors.black,
            ),
            onPressed: () {
              searchBar.rows.value--;
              searchBar.deleteCondition(index);
            },
          ),
        ],
      ),
    );
  }
}
