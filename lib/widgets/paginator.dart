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
  final controller = TextEditingController();
  final FocusNode focus = FocusNode();
  bool settings = false;

  @override
  void initState() {
    // focus.addListener(selection);
    paginator.page.listen((value) {
      if (mounted) {
        setState(() {});
      }
    });
    paginator.rows.listen((value) {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focus.dispose();
    //application.dispose();
    //paginator.dispose();
    super.dispose();
  }

  // void selection() {
  //   debugPrint('selection');
  //   if (focus.hasFocus) {
  //     debugPrint('focus');
  //     controller.selection = TextSelection.collapsed(
  //       offset: controller.text.length,
  //     );
  //     // setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    application.notch.value = true;

    controller.text = '${paginator.rows.value}';

    return Column(
      children: [
        Expanded(
          child: Stack(children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: widget.child
            ),
            // const Ruler(),
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
                      padding: const EdgeInsets.all(6.0),
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
                              autofocus: true,
                              focusNode: focus,
                              controller: controller,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (value) {
                                settings = false;
                                setState(() {});
                              },
                              onChanged: (value) {
                                if (value != '') {
                                  paginator.rows.value = int.parse(value);
                                  // controller.value = TextEditingValue(
                                  //   selection: TextSelection.collapsed(
                                  //     offset: -value.length
                                  //   )
                                  // );
                                }
                              },
                              textAlign: TextAlign.end,
                              // textDirection: TextDirection.ltr,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                isDense: true,
                                filled: true,
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    // focus.unfocus();
                                    paginator.rows.value--;
                                    // controller.text = '${paginator.rows.value}';
                                    final String value =
                                      '${paginator.rows.value}';
                                    controller.text = value;
                                    // Future.delayed(Duration.zero, () {
                                    // focus.requestFocus();
                                    // });
                                    // Future.delayed(Duration.zero, () {
                                    //   controller.value = TextEditingValue(
                                    //     text: value,
                                    //     // selection: TextSelection.collapsed(
                                    //     //  offset: value.length
                                    //     selection: TextSelection(
                                    //       baseOffset: 0, // value.length,
                                    //       extentOffset: value.length
                                    //     )
                                    //   );
                                    // });
                                    // setState(() {});
                                  },
                                  icon: const Icon(Icons.remove)
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    paginator.rows.value++;
                                    controller.text = '${paginator.rows.value}';
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.add)
                                ),
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
        Container(
          color: Colors.blue,
          height: 42.0,
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
                          style: const TextStyle(color: Colors.white)
                        ),
                        const Text(' from ',
                          style: TextStyle(color: Colors.white)
                        ),
                        Text('${paginator.from}',
                          style: const TextStyle(color: Colors.white)
                        ),
                        const Text(' to ',
                          style: TextStyle(color: Colors.white)
                        ),
                        Text('${paginator.to}',
                          style: const TextStyle(color: Colors.white)
                        ),
                        const Text(' of ',
                          style: TextStyle(color: Colors.white)
                        ),
                        Text('${paginator.count.value}',
                            style: const TextStyle(color: Colors.white)),
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

class Ruler extends StatelessWidget {
  const Ruler({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        painter: Painter(context),
      )
    );
  }
}

class Painter extends CustomPainter {
  Painter(BuildContext context) {
    media = MediaQuery.of(context);
  }

  late MediaQueryData media;
  static const double headingRowHeight = 56.0;
  static const double paginatorHeight = 42.0;
  static const double padding = 0.0;
  // rows = (safe / kMinInteractiveDimension).floor();

  @override
  void paint(Canvas canvas, Size size) {
    double y = 0;
    int count = 0;
    final red = Paint()
      ..color = Colors.red
      ..strokeWidth = 1;
    final green = Paint()
      ..color = Colors.green
      ..strokeWidth = 1;
    double height = media.size.height - media.padding.top - 2 * padding -
      media.padding.bottom - kToolbarHeight - paginatorHeight;
    canvas.drawLine(Offset.zero, Offset(media.size.width, height), red);
    canvas.drawLine(Offset(0, height), Offset(media.size.width, 0), red);
    canvas.drawLine(Offset.zero, Offset(size.width, size.height), red);
    canvas.drawLine(Offset(0, size.height), Offset(size.width, 0), red);
    canvas.drawLine(Offset(0, y), Offset(size.width, y), red);
    y += padding;
    canvas.drawLine(Offset(0, y), Offset(size.width, y), red);
    y += headingRowHeight;
    canvas.drawLine(Offset(0, y), Offset(size.width, y), red);
    debugPrint('Filas: $count');
      
    while (true) {
      y += kMinInteractiveDimension;
      if (y > height) break;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), green);
      count++;
      final text = reference('$count: ${y}px', size.width);
      text.paint(canvas, Offset(2, y - 10));
      debugPrint('Filas: $count');
    }
    y = size.height;
    canvas.drawLine(Offset(0, y), Offset(size.width, y), red);
    height -= headingRowHeight;
    final int rows = (height / kMinInteractiveDimension).floor();
    debugPrint('Filas: $count ($rows)');
  }

  TextPainter reference(String text, double width) {
    return TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 8,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(
      minWidth: 0,
      maxWidth: width,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}