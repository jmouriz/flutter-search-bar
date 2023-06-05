import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:mutable_icon/mutable_icon.dart';
import 'package:toolbar/models/models.dart';
import 'package:toolbar/providers/providers.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({
    super.key,
    required this.items,
    this.onSelect,
  });

  final ItemsModel items;
  final Function? onSelect;

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget>
  with TickerProviderStateMixin {
  ItemsModel items = ItemsModel();
  bool submenu = false;
  bool animate = false;

  @override
  initState() {
    items = widget.items;
    animate = false;
    submenu = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final Random random = Random();
    // final int id = 100 + random.nextInt(999 - 100);
    final singleChildScrollView = SingleChildScrollView(
      // key: ValueKey<String>('id-$id'),
      child: Column(
        children: [
          if (submenu) ListTile(
            leading: const Icon(Icons.chevron_left),
            title: const Text('Volver'),
            iconColor: ThemeProvider().foreground,
            textColor: ThemeProvider().foreground,
            onTap: () {
              items = widget.items;
              submenu = false;
              animate = true;
              setState(() {});
            }
          ),
          ...List.generate(items.length, (index) {
            final item = items[index];
            if (item.submenu) {
              debugPrint(item.title);
              debugPrint('${items[index].items}');
            }
            if (item.setup != null) {
              Future.delayed(Duration.zero, () {
                item.setup(item, context);
              });
            }
            final Widget? trailing;

            if (item.submenu) {
              switch (item.mode) {
                case Mode.expand:
                  trailing = MutableIcon(
                    duration: const Duration(milliseconds: 300),
                    startIcon: Icons.expand_more,
                    endIcon: Icons.expand_less,
                    startIconColor: ThemeProvider().foreground,
                    endIconColor: ThemeProvider().foreground,
                    controller: item.controller,
                    initFrom: item.expanded ? InitFrom.end : InitFrom.start
                  );
                  break;
                case Mode.replace:
                  trailing = const Icon(Icons.chevron_right);
                  break;
                default:
                  trailing = null;
              }
            } else {
              trailing = null;
            }

            return Column(
              children: [
                if (item.visible && item.show(item)) ListTile(
                  leading: item.icon is IconData ? Icon(item.icon) : item.icon,
                  trailing: trailing,
                  // const Icon(Icons.arrow_drop_up)
                  // const Icon(Icons.arrow_drop_down)
                  horizontalTitleGap: 0,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                  iconColor: ThemeProvider().foreground,
                  textColor: ThemeProvider().foreground,
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(item.title),
                      ),
                      if (item.badge != null) Badge(
                        label: Text('${item.badge}',
                          style: const TextStyle(
                            color: Colors.white, // TODO
                          ),
                        ),
                      ),
                    ]
                  ),
                  onTap: () {
                    if (item.submenu) {
                      if (item.mode == Mode.expand) {
                        item.expanded
                          ? item.controller.animateToStart()
                          : item.controller.animateToEnd();
                        item.expanded = !item.expanded;
                      }

                      if (item.mode == Mode.replace) {
                        items = item.items;
                        submenu = true;
                      }

                      setState(() {});
                    } else {
                      if (item.callback == null) {
                        if (widget.onSelect != null) {
                          widget.onSelect!(index);
                        }
                      } else {
                        var state = item.callback(item, context);
                        if (state != null && state) {
                          setState(() {});
                        }
                      }
                    }
                  },
                ),
                if (item.submenu && item.mode == Mode.expand) AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder:
                    (Widget child, Animation<double> animation) {
                    return SizeTransition(sizeFactor: animation, child: child);
                  },
                  child: item.expanded ? Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: MenuWidget(items: item.items),
                  ) : null,
                ),
              ],
            );
          }).toList(),
        ]
      ),
    );
    return ClipRect(child: submenu ? SlideInRight(
      duration: const Duration(milliseconds: 200),
      child: singleChildScrollView
    ) : animate ? SlideInLeft(
      duration: const Duration(milliseconds: 200),
      child: singleChildScrollView
    ) : singleChildScrollView
    );
  }
}