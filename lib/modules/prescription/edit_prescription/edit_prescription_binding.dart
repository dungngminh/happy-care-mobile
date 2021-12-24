import 'package:get/get.dart';
import 'package:happy_care/modules/prescription/edit_prescription/edit_prescription_controller.dart';

class EditPrescriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditPrescriptionController());
  }
}
