import 'package:get/get.dart';
import 'package:happy_care/modules/home/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
  }
}
