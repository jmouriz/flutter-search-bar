import 'package:flutter/material.dart';

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
        style: const TextStyle(
          color: Colors.blue,
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