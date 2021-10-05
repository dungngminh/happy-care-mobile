import 'package:get/get.dart';

class SignInController extends GetxController {
  final _isHidePassword = true.obs;

  bool get isHidePassword => _isHidePassword.value;

  SignInController();

  turnOnOffHiddenPassword() {
    _isHidePassword.value = !_isHidePassword.value;
    update();
  }
}
