import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_care/modules/prescription/prescription_controller.dart';

class PrescriptionScreen extends GetView<PrescriptionController> {
  const PrescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("prescription"),
    );
  }
}
