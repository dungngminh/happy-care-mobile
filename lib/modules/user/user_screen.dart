import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/modules/user/user_controller.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: kMainColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(26),
                        bottomRight: Radius.circular(26),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 120,
                  height: 180,
                  width: 180,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kSecondColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 130,
                  height: 160,
                  width: 160,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kMainColor,
                    ),
                  ),
                ),
                Obx(() {
                  final status = controller.status.value;
                  if (status == Status.loading) {
                    return Positioned(
                      left: 180,
                      bottom: 50,
                      child: SpinKitThreeBounce(
                        size: 26,
                        color: Colors.white,
                      ),
                    );
                  } else if (status == Status.error) {
                    return Text("Error",
                        style: GoogleFonts.openSans(color: kSecondColor));
                  } else {
                    return Positioned(
                      left: 95,
                      bottom: 70,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Builder(
                          builder: (context) {
                            if (controller.user.value.profileUser?.fullName !=
                                null) {
                              return Text(
                                controller.user.value.email,
                                style: GoogleFonts.openSans(
                                  color: kSecondColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            } else
                              return Column(
                                children: [
                                  Text(
                                    controller
                                            .user.value.profileUser?.fullName ??
                                        'hello',
                                    style: GoogleFonts.openSans(
                                      color: kSecondColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    controller.user.value.email,
                                    style: GoogleFonts.openSans(
                                      color: kSecondColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                          },
                        ),
                      ),
                    );
                  }
                }),
              ],
            ),
            ElevatedButton(
              onPressed: () => controller.signOut(),
              child: Text("Sign out"),
            ),
          ],
        ),
      ),
    );
  }
}
