import 'package:get/get.dart';
import 'package:happy_care/data/models/prescription/prescription.dart';
import 'package:happy_care/data/models/user.dart';
import 'package:happy_care/modules/prescription/prescription_controller.dart';
import 'package:happy_care/modules/user/user_controller.dart';

enum DetailPrescriptionStatus { loading, error, done }

class DetailPrescriptionController extends GetxController {
  final PrescriptionController preController = Get.find();
  final UserController userController = Get.find();
  final user = User.init().obs;
  final status = DetailPrescriptionStatus.loading.obs;
  final prescription = Get.arguments as Prescription;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (userController.user.value.role == 'doctor') {
      await userController.userRepository!
          .getUserById(prescription.member!)
          .then((data) {
        status(DetailPrescriptionStatus.done);
        user(data);
      }).onError((error, stackTrace) {
        status(DetailPrescriptionStatus.loading);
      });
    } else {
      await userController.userRepository!
          .getUserById(prescription.doctor!)
          .then((data) {
        status(DetailPrescriptionStatus.done);
        user(data);
      }).onError((error, stackTrace) {
        status(DetailPrescriptionStatus.loading);
      });
    }
  }
}
