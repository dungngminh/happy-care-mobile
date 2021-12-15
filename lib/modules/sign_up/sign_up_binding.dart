import 'package:get/get.dart';
import 'package:happy_care/data/services/my_cloudinary_service.dart';
import 'package:happy_care/modules/main_screen/controller/image_controller.dart';
import 'package:happy_care/modules/sign_up/sign_up_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyCloudinaryService?>(() => MyCloudinaryService());
    Get.lazyPut(() => ImageController());
    Get.lazyPut(() => SignUpController(userRepository: Get.find()));
  }
}
