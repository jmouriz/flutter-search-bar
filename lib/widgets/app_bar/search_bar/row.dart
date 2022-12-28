import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/widgets/app_bar/search_bar/search_bar.dart';

class SearchBarRowWidget extends StatelessWidget {
  SearchBarRowWidget({
    this.index,
    super.key
  });

  final index;
  final _searchBar = Get.put(SearchBarController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        children: [
          SearchBarPopupWidget(),
          Expanded(
            child: SearchBarInputWidget(index: index),
          ),
          IconButton(
            icon: const Icon(
              Icons.remove,
              color: Colors.black,
            ),
            onPressed: () {
              _searchBar.rows.value--;
            },
          ),
        ],
      ),
    );
  }
}
