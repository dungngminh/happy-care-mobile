import 'package:get/get.dart';
import 'package:happy_care/data/repositories/user_repository.dart';
import 'package:happy_care/data/services/user_api.dart';
import 'package:happy_care/modules/sign_in/sign_in_controller.dart';
import 'package:http/http.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserApi?>(() => UserApi(Client()));
    Get.lazyPut<UserRepository?>(() => UserRepository(userApi: Get.find()));
    Get.lazyPut(() => SignInController(userRepository: Get.find()));
  }
}
