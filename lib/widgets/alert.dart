import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class AlertWidget extends StatefulWidget {
  const AlertWidget({super.key});

  @override
  State<AlertWidget> createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {
  final alert = Get.put(AlertController());

  @override
  void initState() {
    alert.open.listen((value) {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (!mounted) {
      alert.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData query = MediaQuery.of(context);
    final width = query.size.width;
    final bottom = query.padding.bottom;
    final EdgeInsets padding;
    const value = 10.0;

    if (bottom > 0) {
      padding = const EdgeInsets.only(
        left: value,
        right: value,
      );
    } else {
      padding = const EdgeInsets.only(
        left: value,
        right: value,
        bottom: value,
      );
    }

    final container = Padding(
      padding: padding,
      child: SizedBox(
        width: width - 2 * value,
        child: Material(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red.shade700,
            elevation: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (alert.title != null) Text(
                          alert.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          alert.message,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                IconButton(
                  onPressed: () => alert.open.value = false,
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            )
          )
        ),
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        double begin = animation.isCompleted ? -1.0 : 1.0;
        if (alert.open.value) {
          begin *= -1;
        }
        return SlideTransition(
            position: Tween(begin: Offset(0.0, begin), end: Offset.zero)
                .animate(animation),
            child: child);
      },
      child: alert.open.value ? container : null,
    );
  }
}
