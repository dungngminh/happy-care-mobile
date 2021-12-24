import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_care/core/helpers/show_custom_dialog.dart';
import 'package:happy_care/core/utils/validator.dart';
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
  final hide1 = true.obs;
  final hide2 = true.obs;
  final hide3 = true.obs;
  final UserRepository? userRepository;
  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController rePassController = TextEditingController();
  final SocketIOService? socketIOService;
  final ImageController imageController = Get.find();
  UserController({this.userRepository, this.socketIOService});

  @override
  Future<void> onInit() async {
    super.onInit();
    await getUserInformation();
  }

  Future<void> signOut(BuildContext context) async {
    showLoadingDialog(context, contentDialog: "Đang đăng xuất...");
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

  Future<void> changePassword(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await Future.delayed(Duration(milliseconds: 300));
    print(oldPassController.text +
        "_" +
        newPassController.text +
        "_" +
        rePassController.text);
    if (oldPassController.text.isEmpty ||
        newPassController.text.isEmpty ||
        oldPassController.text.isEmpty) {
      MyToast.showErrorToast(context, "Không được để trống thông tin");
    } else if (!ValidatorUtils.checkPassword(newPassController.text)) {
      MyToast.showErrorToast(context,
          "Mật khẩu mới phải có ít nhất 1 chữ in hoa, 1 chữ thường, 1 chữ số");
    } else if (newPassController.text != rePassController.text) {
      MyToast.showErrorToast(context, "Nhập lại mật khẩu mới không trùng");
    } else {
      showLoadingDialog(context, contentDialog: "Đang đổi mật khẩu...");
      await userRepository!
          .changePassword(oldPassController.text, newPassController.text)
          .then((value) {
        Get.back();
        Get.back();
        resetValue();
        MyToast.showToast("Đổi mật khẩu thành công");
      }).onError((error, stackTrace) {
        Get.back();
        MyToast.showErrorToast(context, "Sai mật khẩu cũ");
      });
    }
  }

  resetValue() {
    oldPassController.text = '';
    newPassController.text = '';
    rePassController.text = '';
    hide1(hide2(hide3(true)));
  }
}
