import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/application.dart';

class PaginatorPage extends StatefulWidget {
  const PaginatorPage({ super.key });

  @override
  State<PaginatorPage> createState() => _PaginatorPageState();
}

class _PaginatorPageState extends State<PaginatorPage> {
  final application = Get.put(ApplicationController());
  bool settings = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    application.notch.value = true;

    return Column(
      children: [
        Expanded(
          child: Stack(children: [
            const Placeholder(),
            Positioned(
              bottom: 8.0,
              left: 8.0,
              right: 8.0,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder:
                  (Widget child, Animation<double> animation) {
                  double begin = animation.isCompleted ? 1.0 : -1.0;
                  if (settings) {
                    begin *= -1;
                  }
                  return SlideTransition(
                    position: Tween(
                      begin: Offset(0.0, begin),
                      end: Offset.zero
                    ).animate(animation),
                    child: child
                  );
                },
                child: settings ? SizedBox(
                  width: double.infinity,
                  child: Material(
                    borderRadius: BorderRadius.circular(5),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text('Rows per page'),
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                isDense: true,
                                filled: true,
                                fillColor: Colors.grey.shade300,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 8.0
                                )
                                //hoverColor: Colors.grey.shade500,
                                //focusColor: Colors.grey.shade500,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              settings = false;
                              setState(() {});
                            },
                            icon: const Icon(Icons.done),
                          )
                        ],
                      ),
                    ),
                  ),
                ) : null,
              )
            )
          ]),
        ),
        ColoredBox(
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                    onTap: () => debugPrint('first'),
                    child: const Icon(Icons.first_page, color: Colors.white)),
                InkWell(
                  onTap: () => debugPrint('previous'),
                  child: const Icon(Icons.chevron_left, color: Colors.white),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      settings = !settings;
                      setState(() {});
                    },
                    child: Row(
                      children: const [
                        Text('1000', style: TextStyle(color: Colors.white)),
                        Text(' del ', style: TextStyle(color: Colors.white)),
                        Text('10000', style: TextStyle(color: Colors.white)),
                        Text(' al ', style: TextStyle(color: Colors.white)),
                        Text('11000', style: TextStyle(color: Colors.white)),
                        Text(' de ', style: TextStyle(color: Colors.white)),
                        Text('1000000000',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => debugPrint('next'),
                  child: const Icon(Icons.chevron_right, color: Colors.white),
                ),
                InkWell(
                  onTap: () => debugPrint('last'),
                  child: const Icon(Icons.last_page, color: Colors.white),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
