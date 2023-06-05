import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/providers/providers.dart';

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
                                }
                              },
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                isDense: true,
                                filled: true,
                                prefixIcon: IconButton(
                                  onPressed: paginator.rows.value > 1 ? () {
                                    paginator.rows.value--;
                                    final String value =
                                      '${paginator.rows.value}';
                                    controller.text = value;
                                  } : null,
                                  icon: const Icon(Icons.remove)
                                ),
                                suffixIcon: IconButton(
                                  onPressed: paginator.rows.value < 100 ? () {
                                    paginator.rows.value++;
                                    controller.text = '${paginator.rows.value}';
                                    setState(() {});
                                  } : null,
                                  icon: const Icon(Icons.add)
                                ),
                                fillColor: Colors.grey.shade300,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 6.0,
                                  horizontal: 8.0
                                )
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
          color: ThemeProvider().primary,
          height: 42.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PaginatorButton(
                  icon: Icons.first_page,
                  enabled: paginator.canFirst,
                  callback: paginator.first,
                ),
                PaginatorButton(
                  icon: Icons.chevron_left,
                  enabled: paginator.canPrevious,
                  callback: paginator.previous,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      settings = !settings;
                      setState(() {});
                    },
                    child: PaginatorDetail(paginator: paginator),
                  ),
                ),
                PaginatorButton(
                  icon: Icons.chevron_right,
                  enabled: paginator.canNext,
                  callback: paginator.next,
                ),
                PaginatorButton(
                  icon: Icons.last_page,
                  enabled: paginator.canLast,
                  callback: paginator.last,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class PaginatorDetail extends StatelessWidget {
  const PaginatorDetail({
    super.key,
    required this.paginator,
  });

  final PaginatorController paginator;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class PaginatorButton extends StatelessWidget {
  const PaginatorButton({
    super.key,
    required this.icon,
    required this.callback,
    this.enabled = true,
  });

  final IconData icon;
  final Function callback;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? () => callback() : null,
      child: Icon(icon,
        color: enabled
          ? Colors.white
          : Colors.grey.shade400
      )
    );
  }
}