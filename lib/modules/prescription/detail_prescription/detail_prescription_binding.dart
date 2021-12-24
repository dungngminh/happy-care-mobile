import 'package:get/get.dart';
import 'package:happy_care/modules/prescription/detail_prescription/detail_prescription_controller.dart';

class DetailPrescriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailPrescriptionController());
  }
}
