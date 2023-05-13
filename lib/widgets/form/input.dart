import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/models/models.dart';
import 'package:toolbar/types/types.dart';

class GenericInputWidget extends StatefulWidget {
  const GenericInputWidget({
    super.key,
    required this.name,
    required this.label,
    this.type = Input.text,
    this.next = false,
  });

  final String name;
  final String label;
  final Input type;
  final bool next;

  @override
  State<GenericInputWidget> createState() => _GenericInputWidgetState();
}

class _GenericInputWidgetState extends State<GenericInputWidget> {
  final FocusNode _focus = FocusNode();
  final form = Get.put(FormController());
  late final FieldModel _field;
  bool _touched = false;

  TextInputType keyboard = TextInputType.text;
  bool obscure = false;

  void _touch() {
    if (_focus.hasFocus) {
      _touched = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _field = FieldModel(name: widget.name);
    form.fields.add(_field);
    switch (widget.type) {
      case Input.password:
        keyboard = TextInputType.visiblePassword;
        obscure = true;
        break;
      case Input.email:
        keyboard = TextInputType.visiblePassword;
        break;
      case Input.name:
        keyboard = TextInputType.name;
        break;
      case Input.address:
        keyboard = TextInputType.streetAddress;
        break;
      case Input.url:
        keyboard = TextInputType.url;
        break;
      case Input.phone:
        keyboard = TextInputType.phone;
        break;
      case Input.number:
        keyboard = TextInputType.number;
        break;
      case Input.text:
      case Input.date:
      case Input.time:
      case Input.check:
      case Input.decimal:
    }
    _focus.addListener(_touch);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focus,
      keyboardType: keyboard,
      obscureText: obscure,
      textInputAction: widget.next
        ? TextInputAction.next
        : TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: (String value) {
        _focus.unfocus();
        FocusScope.of(context).requestFocus(_focus);
      },
      validator: (value) {
        debugPrint('validator');
        if (!_touched) return null;
        if (value != null) {
          if (value == '') return 'Required';
          if (value.length < 3) return 'Minlength: 3';
        }
        return null;
      },
      //initialValue: condition.value,
      style: const TextStyle(fontSize: 20),
      decoration: InputDecoration(
        hintText: widget.label,
        helperText: '',
        label: Text(widget.label),
        suffixIcon: widget.type == Input.password ? IconButton(
          icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            obscure = !obscure;
            setState(() {});
          }
        ) : null,
      ),
      onChanged: (value) {
        //debugPrint(value);
        debugPrint('field onChanged');
        if (!_touched) {
          _field.valid = true;
          return;
        }
        if (value == '') {
          _field.valid = false;
          return;
        } else if (value.length < 3) {
          _field.valid = false;
          return;
        }
        _field.value = value;
        _field.valid = true;
      }
    );
  }
}