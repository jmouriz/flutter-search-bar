import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class PaginatorWidget extends StatefulWidget {
  const PaginatorWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<PaginatorWidget> createState() => _PaginatorWidgetState();
}

class _PaginatorWidgetState extends State<PaginatorWidget> {
  final application = Get.put(ApplicationController());
  final paginator = Get.put(PaginatorController());
  bool settings = false;

  @override
  void initState() {
    paginator.page.listen((value) => setState(() {}));
    paginator.rows.listen((value) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    application.notch.value = true;

    return Column(
      children: [
        Expanded(
          child: Stack(children: [
            widget.child,
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
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text('Rows per page'),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              initialValue: '${paginator.rows.value}',
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
                                  vertical: 6.0,
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
                  onTap: () => paginator.first(),
                  child: const Icon(Icons.first_page, color: Colors.white)
                ),
                InkWell(
                  onTap: () => paginator.previous(),
                  child: const Icon(Icons.chevron_left, color: Colors.white),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      settings = !settings;
                      setState(() {});
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${paginator.page.value}',
                          style: TextStyle(color: Colors.white)
                        ),
                        const Text(' from ',
                          style: TextStyle(color: Colors.white)
                        ),
                        Text('${paginator.rows.value * paginator.page.value}',
                          style: TextStyle(color: Colors.white)
                        ),
                        const Text(' to ',
                          style: TextStyle(color: Colors.white)
                        ),
                        Text('${paginator.rows.value * (paginator.page.value + 1)}',
                          style: TextStyle(color: Colors.white)
                        ),
                        const Text(' of ',
                          style: TextStyle(color: Colors.white)
                        ),
                        Text('${paginator.count.value}',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => paginator.next(),
                  child: const Icon(Icons.chevron_right, color: Colors.white),
                ),
                InkWell(
                  onTap: () => paginator.last(),
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
