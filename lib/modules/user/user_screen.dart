import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_care/modules/user/user_controller.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text("${controller.index}")),
            ElevatedButton(
              onPressed: () => controller.updateIndex(),
              child: Text("+"),
            ),
            ElevatedButton(
              child: Text("SignOut"),
              onPressed: () => controller.signOut(),
            ),
          ],
        ),
      ),
    );
  }
}
