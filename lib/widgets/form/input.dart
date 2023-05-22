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
    this.visible = true,
    this.next = false,
  });

  final String name;
  final String label;
  final Input type;
  final bool visible;
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
    _field.visible = widget.visible;
    form.fields.add(_field);
    switch (widget.type) {
      case Input.password:
        keyboard = TextInputType.visiblePassword;
        obscure = true;
        break;
      case Input.email:
        keyboard = TextInputType.emailAddress;
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
      case Input.decimal:
        keyboard = const TextInputType.numberWithOptions(decimal: true);
        break;
      case Input.pin:
        keyboard = TextInputType.number;
        obscure = true;
        break;
      case Input.text:
        keyboard = TextInputType.text;
        break;
      case Input.date:
        keyboard = TextInputType.datetime;
        break;
      case Input.time:
        keyboard = TextInputType.datetime;
        break;
      case Input.check:
        // TODO
    }
    _focus.addListener(_touch);
  }

  @override
  Widget build(BuildContext context) {
    return !widget.visible ? const SizedBox.shrink() : TextFormField(
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
        ) : widget.type == Input.date || widget.type == Input.time ? IconButton(
          icon: const Icon(Icons.calendar_month_outlined),
          onPressed: () async {
            DateTime? date = await showDatePicker(
              locale: const Locale('es', 'AR'),
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2101),
              builder: (BuildContext context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    dialogTheme: DialogTheme(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            debugPrint(date.toString());
          },
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