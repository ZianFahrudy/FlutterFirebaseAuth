import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:googlesignin/app/controller/my_controller.dart';

import 'dynamic_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const DynamicPage()));
      }),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                onPressed: () {
                  controller.googleLogin();
                },
                icon: const Icon(FontAwesomeIcons.google),
                label: const Text('Sign In With Google')),
            ElevatedButton.icon(
                onPressed: () {
                  controller.facebookLogin();
                },
                icon: const Icon(FontAwesomeIcons.facebook),
                label: const Text('Sign In With Facebook')),
          ],
        ),
      ),
    );
  }
}
