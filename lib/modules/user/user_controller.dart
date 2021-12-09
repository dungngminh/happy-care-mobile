import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/data/models/user.dart';
import 'package:happy_care/data/repositories/user_repository.dart';
import 'package:happy_care/data/services/socket_io_service.dart';
import 'package:happy_care/modules/main_screen/controller/image_controller.dart';
import 'package:happy_care/routes/app_pages.dart';
import 'package:happy_care/widgets/my_toast.dart';

enum UserStatus { loading, done, error }

class UserController extends GetxController {
  var user = User.init().obs;
  final status = UserStatus.loading.obs;
  final UserRepository? userRepository;
  final SocketIOService? socketIOService;
  final ImageController imageController = Get.find();
  UserController({this.userRepository, this.socketIOService});

  @override
  Future<void> onInit() async {
    super.onInit();
    await getUserInformation();
  }

  Future<void> signOut(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(color: kMainColor),
          );
        });
    socketIOService!.signOut();
    await userRepository!.signOut().then((value) {
      Get.back();
      MyToast.showToast("Đăng xuất thành công");
      Get.offAllNamed(AppRoutes.rSignIn);
    });
  }

  Future<void> getUserInformation() async {
    status(UserStatus.loading);
    await userRepository!.getUserData().then((data) {
      user(data);
      status(UserStatus.done);
      update();
    }).onError((error, stackTrace) {
      print("$error");
      status(UserStatus.error);
    });
  }
}
