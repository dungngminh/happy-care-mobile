import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeController extends GetxController {
  var userStatus = 0.obs;
  var height = 18.0.h.obs;
  var scale = 1.0.obs;
  var toggle = true.obs;

  ///Action to hide or change status
  onTapAction(bool isSick) {
    isSick ? userStatus(2) : userStatus(1);
    if (userStatus.value == 1) {
      toggle(false);
    }
  }
}
