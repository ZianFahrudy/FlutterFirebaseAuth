import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:googlesignin/app/controller/my_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final controller = Get.put(MyController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              controller.googleLogout();
            },
            icon: const Icon(FontAwesomeIcons.signOutAlt),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                user!.photoURL!,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              user.displayName!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(user.email!)
          ],
        ),
      ),
    );
  }
}
