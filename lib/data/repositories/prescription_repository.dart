import 'dart:convert';

import 'package:happy_care/core/utils/shared_pref.dart';
import 'package:happy_care/data/api/prescription_api.dart';
import 'package:happy_care/data/models/prescription/medicine.dart';
import 'package:happy_care/data/models/prescription/prescription.dart';

class PrescriptionRepository {
  final PrescriptionApi? prescriptionApi;

  PrescriptionRepository({this.prescriptionApi});

  Future<List<Prescription>> getMyPrescription() async {
    try {
      String token = await SharedPrefUtils.getStringKey('token');
      String response = await prescriptionApi!.getMyPrescription(token);
      var converted = jsonDecode(response);
      Iterable list = converted['data']['prescriptions'];
      return list.map((e) => Prescription.fromJson(e)).toList();
    } catch (_) {
      throw Exception();
    }
  }

  Future<String> createNewPrescription(
      {required String diagnose,
      required String memberId,
      required String doctorId,
      required List<Medicine> medicines,
      String? note}) async {
    try {
      String token = await SharedPrefUtils.getStringKey('token');
      final body = {
        'diagnose': diagnose,
        'member': memberId,
        'doctor': doctorId,
        'medicines': medicines.map((e) => e.toJsonNoId()).toList(),
        'note': note,
      };
      String response =
          await prescriptionApi!.createNewPrescription(token, body);
      var converted = jsonDecode(response);
      return converted['data']['prescriptionId'];
    } catch (_) {
      throw Exception();
    }
  }

  Future<void> updatePrescription({
    required String prescriptionId,
    required String diagnose,
    required List<Medicine> medicines,
    String? note,
  }) async {
    try {
      String token = await SharedPrefUtils.getStringKey('token');
      final body = {
        'diagnose': diagnose,
        'medicines': medicines.map((e) => e.toJsonNoId()).toList(),
        'note': note,
      };
      await prescriptionApi!.updatePrescription(token, prescriptionId, body);
    } catch (_) {
      throw Exception();
    }
  }
}
