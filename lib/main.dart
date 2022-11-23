import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Demo',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.lightBlue[50],
          body: const HomeWidget(),
        ));
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: MediaQuery.of(context).padding.top,
        width: double.infinity,
        color: Colors.blue,
      ),
      const AppBarWidget(),
      const BodyWidget(),
    ]);
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Text(
          'SearchBar Demo',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
          )
        )
      ),
    );
  }
}

class AppBarController extends GetxController {
  var searching = false.obs;
}

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  final _controller = Get.put(AppBarController());

  @override
  void initState() {
    _controller.searching.listen((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    if (!mounted) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            double begin = animation.isCompleted ? 1.0 : -1.0;
            if (_controller.searching.value) {
              begin *= -1;
            }
            return SlideTransition(
              position: Tween(begin: Offset(begin, 0.0), end: Offset.zero)
                  .animate(animation),
              child: child,
            );
          },
          child: _controller.searching.value
              ? const SearchbarWidget(key: ValueKey<String>('searchbar'))
              : ToolbarWidget(key: const ValueKey<String>('toolbar'))),
    );
  }
}

class ToolbarWidget extends StatelessWidget {
  ToolbarWidget({super.key});

  final _controller = Get.put(AppBarController());

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
              print('toggle menu');
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
              _controller.searching.value = !_controller.searching.value;
            },
          ),
        ],
      ),
    );
  }
}

class SearchbarController extends GetxController {
  var rows = 1.obs;
}

class SearchbarWidget extends StatefulWidget {
  const SearchbarWidget({super.key});

  @override
  State<SearchbarWidget> createState() => _SearchbarWidgetState();
}

class _SearchbarWidgetState extends State<SearchbarWidget> {
  final _searchbar = Get.put(SearchbarController());

  @override
  void initState() {
    _searchbar.rows.listen((value) {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (!mounted) {
      _searchbar.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _searchbar.rows.value * kToolbarHeight,
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchbarMainWidget(),
              ...List.generate(_searchbar.rows.value, (index) {
                return SearchbarRowWidget();
              }).toList(),
            ]
          ),
        ));
  }
}

class SearchbarMainWidget extends StatelessWidget {
  SearchbarMainWidget({super.key});

  final _controller = Get.put(AppBarController());
  final _searchbar = Get.put(SearchbarController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onPressed: () {
              _searchbar.rows.value++;
            },
          ),
          const Expanded(
            child: SearchbarInputWidget(),
          ),
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              Timer(Duration(milliseconds: 35 * _searchbar.rows.value), () {
                _controller.searching.value = !_controller.searching.value;
              });
              _searchbar.rows.value = 1;
            },
          ),
        ],
      ),
    );
  }
}

class SearchbarRowWidget extends StatelessWidget {
  SearchbarRowWidget({super.key});

  final _searchbar = Get.put(SearchbarController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onPressed: () {
              _searchbar.rows.value++;
            },
          ),
          const Expanded(
            child: SearchbarInputWidget(),
          ),
          IconButton(
            icon: const Icon(
              Icons.remove,
              color: Colors.black,
            ),
            onPressed: () {
              _searchbar.rows.value--;
            },
          ),
        ],
      ),
    );
  }
}

class SearchbarInputWidget extends StatelessWidget {
  const SearchbarInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextFormField(
        autofocus: true,
        initialValue: '',
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: 'Search...',
        ),
      ),
    );
  }
}