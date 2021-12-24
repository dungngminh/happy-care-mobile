import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:happy_care/data/models/prescription/medicine.dart';
import 'package:happy_care/data/models/prescription/prescription.dart';
import 'package:happy_care/modules/prescription/prescription_controller.dart';

class EditPrescriptionController extends GetxController {
  late final TextEditingController diagnoseController;
  late final TextEditingController noteController;
  final PrescriptionController prescriptionController = Get.find();
  final prescripton = Get.arguments as Prescription;
  var listDrug = RxList<Medicine>([]);
  @override
  void onInit() {
    super.onInit();
    diagnoseController = TextEditingController(text: prescripton.diagnose);
    noteController = TextEditingController(text: prescripton.note);
    listDrug(prescripton.medicines);
  }

  removeAtIndex(int index) {
    listDrug.removeAt(index);
    print(prescripton.medicines.toString());
  }
}
