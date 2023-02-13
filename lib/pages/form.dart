import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/models/models.dart';
import 'package:toolbar/types/types.dart';

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final application = Get.put(ApplicationController());
    final form = Get.put(FormController());
    final GlobalKey<FormState> key = GlobalKey<FormState>();

    application.title = 'Form Test';
    application.done = () => debugPrint('next');
    form.fields.clear();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: key,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: () {
          Future.delayed(Duration.zero, () {
            print('form onChanged');
            application.valid = form.valid();
          });
        },
        child: Column(
          children: const [
            GenericInputWidget(label: 'EMail', type: Input.email),
            GenericInputWidget(label: 'Password', type: Input.password),
          ],
        ),
      ) 
    );
  }
}

class GenericInputWidget extends StatefulWidget {
  const GenericInputWidget({
    super.key,
    required this.label,
    this.type = Input.text
  });

  final String label;
  final Input type;

  @override
  State<GenericInputWidget> createState() => _GenericInputWidgetState();
}

class _GenericInputWidgetState extends State<GenericInputWidget> {
  final FocusNode _focus = FocusNode();
  final form = Get.put(FormController());
  final _field = FieldModel();
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
          icon: Icon(
            obscure ? Icons.visibility : Icons.visibility_off,
          ),
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
        if (value != null) {
          if (value == '') {
            _field.valid = false;
            return;
          } else if (value.length < 3) {
            _field.valid = false;
            return;
          }
        }
        _field.valid = true;
      }
    );
  }
}