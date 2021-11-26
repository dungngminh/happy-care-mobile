import 'package:get/get.dart';
import 'package:happy_care/data/repositories/user_repository.dart';
import 'package:happy_care/modules/main_screen/controller/doctor_controller.dart';
import 'package:happy_care/modules/main_screen/controller/spec_controller.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;
  var role = "".obs;

  void changeCurrentIndex(int newIndex) {
    currentIndex.value = newIndex;
  }

  UserRepository? userRepository;
  MainController({this.userRepository});

  final SpecController specController = Get.find();
  final DoctorController doctorController = Get.find();

  @override
  Future<void> onInit() async {
    super.onInit();
    await userRepository
        ?.getUserData()
        .then((value) => role.value = value.role);
  }
}
