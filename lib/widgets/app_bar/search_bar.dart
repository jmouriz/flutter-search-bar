import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/widgets/app_bar/search_bar/search_bar.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

enum Direction {
  increase,
  decrease,
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final _searchBar = Get.put(SearchBarController());
  int rows = 0;
  Direction direction = Direction.increase;

  @override
  void initState() {
    rows = _searchBar.rows.value;
    _searchBar.rows.listen((value) {
      if (mounted) {
        direction = rows < value ? Direction.increase : Direction.decrease;
        rows = value;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (!mounted) {
      _searchBar.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: (1 + _searchBar.rows.value) * kToolbarHeight,
      width: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SearchBarMainWidget(),
            ...List.generate(_searchBar.rows.value, (index) {
              bool delay = index == _searchBar.rows.value - 1
                && direction == Direction.increase;
              return FutureBuilder(
                future: delay
                  ? Future.delayed(const Duration(milliseconds: 320))
                  : Future.delayed(Duration.zero),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return SearchBarRowWidget(index: index);
                  }
                  return const Text('');
                }
              );
            }).toList(),
          ]
        ),
      )
    );
  }
}
