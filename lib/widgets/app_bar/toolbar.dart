import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class ToolbarWidget extends StatelessWidget {
  ToolbarWidget({super.key});

  final _appBar = Get.put(AppBarController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      width: double.infinity,
      color: Colors.blue,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              if (Scaffold.of(context).isDrawerOpen) {
                Scaffold.of(context).closeDrawer();
              } else {
                Scaffold.of(context).openDrawer();
              }
            },
          ),
          const Expanded(
            child: Text(
              'SearchBar Widget Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              _appBar.searching.value = true;
            },
          ),
        ],
      ),
    );
  }
}
