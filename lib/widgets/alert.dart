import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class AlertWidget extends StatefulWidget {
  const AlertWidget({ super.key });

  @override
  State<AlertWidget> createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {
  final alert = Get.put(AlertController());
  final sidenav = Get.put(SidenavController());

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
    double width = query.size.width;
    final bottom = query.padding.bottom;
    final EdgeInsets padding;
    final Color background;
    Color foreground = Colors.white;
    const value = 10.0;
    double left = value;

    if (sidenav.open.value) {
      left += 240;
      width -= 240;
    }

    if (bottom > 0) {
      padding = EdgeInsets.only(
        left: left,
        right: value,
        top: value,
      );
    } else {
      padding = EdgeInsets.only(
        left: left,
        right: value,
        top: value,
        bottom: value,
      );
    }

    switch (alert.type) {
      case AlertType.success:
        background = Colors.green.shade700;
        break;
      case AlertType.error:
        background = Colors.red.shade700;
        break;
      case AlertType.warning:
        foreground = Colors.black;
        background = Colors.yellow.shade700;
        break;
      case AlertType.info:
        background = Colors.blue.shade700;
        break;
      case AlertType.normal:
        background = Colors.grey.shade700;
        break;
      default:
        foreground = Colors.black;
        background = Colors.white;
    }

    final container = Padding(
      padding: padding,
      child: SizedBox(
        width: width - 2 * value,
        child: Material(
            borderRadius: BorderRadius.circular(10),
            color: background,
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
                          style: TextStyle(
                            color: foreground,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          alert.message,
                          style: TextStyle(color: foreground),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                IconButton(
                  onPressed: () => alert.close(),
                  icon: Icon(
                    Icons.close,
                    color: foreground
                  ),
                ),
              ],
            )
          )
        ),
    );

    return ClipRect(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          double begin = animation.isCompleted ? -1.0 : 1.0;
          if (alert.open.value) {
            begin *= -1;
          }
          return SlideTransition(
            position: Tween(begin: Offset(0.0, begin), end: Offset.zero)
              .animate(animation),
            child: child,
          );
        },
        child: alert.open.value ? container : null,
      ),
    );
  }
}
