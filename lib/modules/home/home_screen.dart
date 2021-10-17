import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_care/modules/home/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Chào buổi sáng, Dũng"),
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          Image.asset('assets/images/icon.png').image,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
