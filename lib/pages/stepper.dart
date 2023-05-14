import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/types/types.dart';
import 'package:toolbar/widgets/widgets.dart';

class StepperPage extends StatelessWidget {
  const StepperPage({super.key});

  @override
  Widget build(BuildContext context) {
    final application = Get.put(ApplicationController());
    final form = Get.put(FormController());
    final GlobalKey<FormState> key = GlobalKey<FormState>();

    application.title = 'Form Stepper Test';
    application.done = () {
      debugPrint('done');
      application.busy = true;
      form.values();
    }; // debugPrint('next');
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
        child: const Column(
          children: [
            GenericInputWidget(
              name: 'email',
              label: 'EMail',
              type: Input.email,
              next: true
            ),
            GenericInputWidget(
              name: 'password',
              label: 'Password',
              type: Input.password
            ),
          ],
        ),
      ) 
    );
  }
}