import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/types/types.dart';
import 'package:toolbar/widgets/widgets.dart';

class FormPage extends StatefulWidget {
  const FormPage({ super.key });

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  late bool register;

  @override
  void initState() {
    register = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    final application = Get.put(ApplicationController());
    final form = Get.put(FormController());

    application.title = 'Form Test';
    application.done = () {
      application.busy = true;
      Future.delayed(const Duration(seconds: 2), () {
        application.busy = false;
        register = !register;
        setState(() {});
      });
    };
    form.fields.clear();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: key,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: () {
          Future.delayed(Duration.zero, () {
            debugPrint('form onChanged');
            application.valid = form.valid();
          });
        },
        child: Column(
          children: [
            const GenericInputWidget(
              name: 'email',
              label: 'EMail',
              type: Input.email,
              next: true
            ),
            ClipRect(
              child: SlideInDown(
                child: GenericInputWidget(
                  name: 'code',
                  label: 'Verification code',
                  visible: register,
                  type: Input.pin,
                ),
              ),
            ),
            const GenericInputWidget(
              name: 'password',
              label: 'Password',
              type: Input.password
            ),
            ClipRect(
              child: SlideInDown(
                child: GenericInputWidget(
                  name: 'repeat-password',
                  label: 'Password repeat',
                  visible: register,
                  type: Input.password
                ),
              ),
            ),
          ],
        ),
      ) 
    );
  }
}