import 'package:get/get.dart';

import 'edit_information_controller.dart';

class EditInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditInformationController());
  }
}
