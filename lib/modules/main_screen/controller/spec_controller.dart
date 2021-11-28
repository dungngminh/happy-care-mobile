import 'package:get/get.dart';
import 'package:happy_care/data/models/specialization.dart';
import 'package:happy_care/data/repositories/spec_repository.dart';

class SpecController extends GetxController {
  List<Specialization> listSpec = <Specialization>[];
  final SpecializationRepository? _specRepo;
  SpecController({SpecializationRepository? specRepo}) : _specRepo = specRepo;

  @override
  Future<void> onInit() async {
    super.onInit();
    listSpec = await _specRepo!.getAllSpecAvaliable();
  }
}
