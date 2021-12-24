import 'package:get/get.dart';
import 'package:happy_care/data/models/doctor_inapp.dart';
import 'package:happy_care/data/models/user.dart';
import 'package:happy_care/data/repositories/doctor_repository.dart';
import 'package:happy_care/data/repositories/user_repository.dart';
import 'package:happy_care/data/services/socket_io_service.dart';
import 'package:happy_care/modules/user/user_controller.dart';

enum DocStatus { loading, error, idle }

class DoctorController extends GetxController {
  List<User> listDoctor = [];
  final DoctorRepository? _doctorRepository;
  final UserController userController = Get.find();
  final SocketIOService? _ioService;
  final status = DocStatus.idle.obs;
  List<DoctorInApp> listInApp = [];

  DoctorController(
      {UserRepository? userRepository,
      SocketIOService? ioService,
      DoctorRepository? doctorRepository})
      : _doctorRepository = doctorRepository,
        _ioService = ioService;

  @override
  Future<void> onInit() async {
    super.onInit();
    status(DocStatus.loading);
    listDoctor = await getDoctorMaybeBySpecId(id: null);
    _ioService?.initService();
    await Future.delayed(Duration(seconds: 3)).then((value) async {
      if (userController.user.value.role == "member") await getDoctorOnline();
    });
  }

  Future<void> getDoctorOnline() async {
    while (true) {
      status(DocStatus.loading);
      _ioService?.listDoctor.clear();
      _ioService?.getDoctorInApp();
      await Future.delayed(Duration(seconds: 3)).then((value) {
        status(DocStatus.idle);
        listInApp = _ioService!.listDoctor;
      }).catchError((_) {
        status(DocStatus.error);
      });
      checkOnlineAndSort();
      update();
      await Future.delayed(Duration(seconds: 30));
    }
  }

  Future<List<User>> getDoctorMaybeBySpecId({String? id}) async {
    return await _doctorRepository!.getDoctorMaybeBySpecId(specId: id);
  }

  void checkOnlineAndSort() {
    if (listInApp.isNotEmpty) {
      for (var doctor in listDoctor) {
        for (var inApp in listInApp) {
          if (inApp.userId == doctor.id) {
            doctor.status = inApp.status;
            break;
          } else {
            continue;
          }
        }
      }
      listDoctor.sort((a, b) => b.status!.compareTo(a.status!));
    } else {
      for (var doctor in listDoctor) {
        doctor.status = 0;
      }
      return;
    }
  }
}
