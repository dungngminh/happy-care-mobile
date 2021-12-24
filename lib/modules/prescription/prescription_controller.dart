import 'package:get/get.dart';
import 'package:happy_care/data/models/drug.dart';
import 'package:happy_care/data/models/prescription/medicine.dart';
import 'package:happy_care/data/models/prescription/prescription.dart';
import 'package:happy_care/data/repositories/drug_repository.dart';
import 'package:happy_care/data/repositories/prescription_repository.dart';

enum PrescriptionStatus { loading, error, done }
enum DrugStatus { loading, error, done }

class PrescriptionController extends GetxController {
  final DrugRepository? drugRepository;
  final PrescriptionRepository? prescriptionRepository;
  final drugList = RxList(<Drug>[]);
  final prescriptionList = RxList(<Prescription>[]);
  final prescriptionStatus = PrescriptionStatus.done.obs;
  final drugStatus = DrugStatus.done.obs;
  PrescriptionController({this.drugRepository, this.prescriptionRepository});
  final time = DateTime.now().toLocal().toString().substring(0, 16).obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getMyPresciptions();
    await getAllDrugs();
  }

  Future<void> getMyPresciptions() async {
    prescriptionStatus(PrescriptionStatus.loading);
    await prescriptionRepository!.getMyPrescription().then((value) {
      prescriptionList(value);
      prescriptionList.sort((b, a) =>
          DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!)) > 0
              ? -1
              : 1);
      prescriptionStatus(PrescriptionStatus.done);
    }).onError((error, stackTrace) {
      prescriptionStatus(PrescriptionStatus.error);
    });
    time(DateTime.now().toLocal().toString().substring(0, 16));
  }

  Future<void> getAllDrugs() async {
    drugStatus(DrugStatus.loading);
    await drugRepository!.getAllDrug().then((value) {
      drugList(value);
      drugStatus(DrugStatus.done);
    }).onError((error, stackTrace) {
      drugStatus(DrugStatus.error);
    });
  }

  getDrugById(String drugId) {
    drugList.firstWhere((drug) => drug.id!.contains(drugId));
  }

  Future<String> createNewPrescription({
    required String diagnose,
    required String memberId,
    required String doctorId,
    required List<Medicine> medicines,
    String? note,
  }) async {
    try {
      return await prescriptionRepository!.createNewPrescription(
          diagnose: diagnose,
          memberId: memberId,
          doctorId: doctorId,
          medicines: medicines,
          note: note);
    } catch (_) {
      throw Exception();
    }
  }
}
