import 'package:flutter/material.dart';
import 'package:toolbar/providers/providers.dart';

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
    return InkWell(
      child: Text(_label,
        style: TextStyle(
          color: ThemeProvider().primary,
          decoration: TextDecoration.underline,
        ),
      ),
      onTap: () {
        debugPrint(_target);
        if (_callback != null) {
          _callback!(_target);
        }
      },
    );
  }
}