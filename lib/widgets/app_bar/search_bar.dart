import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/widgets/app_bar/search_bar/search_bar.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

// enum Direction {
//   increase,
//   decrease,
// }

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final searchBar = Get.put(SearchBarController());
  int rows = 0;
  // Direction direction = Direction.increase;

  @override
  void initState() {
    searchBar.rows.value = 0;
    searchBar.setState = setState;
    searchBar.init();
    searchBar.rows.listen((value) {
      if (mounted) {
        // direction = rows < value ? Direction.increase : Direction.decrease;
        rows = value;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (!mounted) {
      searchBar.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('rebuild');
    final media = MediaQuery.of(context);
    final screen =
      media.size.height - media.padding.top - media.padding.bottom;
    int rows = searchBar.rows.value;
    double height = (1 + rows) * kToolbarHeight;

    while (screen / 2 - height < 0) {
      height = (1 + --rows) * kToolbarHeight;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: height,
      width: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: [
              SearchBarMainWidget(),
              ...List.generate(searchBar.rows.value, (index) {
                return SearchBarRowWidget(index: index +1);
                // bool delay = index == searchBar.rows.value - 1
                //   && direction == Direction.increase;
                // return FutureBuilder(
                //   future: delay
                //     ? Future.delayed(const Duration(milliseconds: 320))
                //     : Future.delayed(Duration.zero),
                //   builder: (BuildContext context, AsyncSnapshot snapshot) {
                //     if (snapshot.connectionState == ConnectionState.done) {
                //       return SearchBarRowWidget(index: index +1);
                //     }
                //     return const Text('');
                //   }
                // );
              }).toList(),
            ]
          ),
        ),
      )
    );
  }
}
