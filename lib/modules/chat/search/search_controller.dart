import 'package:get/get.dart';
import 'package:happy_care/data/models/specialization.dart';
import 'package:happy_care/data/models/user.dart';
import 'package:happy_care/modules/main_screen/controller/doctor_controller.dart';
import 'package:happy_care/modules/main_screen/controller/spec_controller.dart';

import '../chat_controller.dart';

enum SearchStatus { loading, done, error }

class SearchController extends GetxController {
  final SpecController _specController = Get.find();
  final DoctorController doctorController = Get.find();
  final ChatController chatController = Get.find();
  final status = SearchStatus.done.obs;
  List<Specialization> listSpec = [];
  Specialization? selected;
  List<User> listDoctor = [];

  @override
  void onInit() {
    super.onInit();
    listSpec = [
      Specialization(id: null, name: "Tất cả"),
      ..._specController.listSpec
    ];
    listDoctor = doctorController.listDoctor;
  }

  categorySelected(Specialization value) async {
    selected = value;
    update();
    if (value.id == null) {
      listDoctor = doctorController.listDoctor;
    } else {
      status(SearchStatus.loading);
      await doctorController.getDoctorMaybeBySpecId(id: value.id).then((value) {
        listDoctor = value;
        status(SearchStatus.done);
      }).onError((error, stackTrace) {
        status(SearchStatus.error);
      });
    }
    update();
  }
}
