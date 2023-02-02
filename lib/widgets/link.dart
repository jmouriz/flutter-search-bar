import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class LinkWidget extends StatelessWidget {
  const LinkWidget({
    Key? key,
    required label,
    target,
    callback,
  }) : 
    _label = label,
    _target = target,
    _callback = callback,
    super(key: key);

  final String _label;
  final String? _target;
  final Function? _callback;

  @override
  Widget build(BuildContext context) {
    return Markdown(
      styleSheet: MarkdownStyleSheet(
        textAlign: WrapAlignment.spaceBetween,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      onTapLink: (text, href, title) {
        //print('$text, $href, $title');
        if (_callback != null) {
          _callback!(href);
        }
      },
      data: '[$_label]($_target "$_label")',
    );
  }
}