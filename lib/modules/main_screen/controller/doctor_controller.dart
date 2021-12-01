import 'package:get/get.dart';
import 'package:happy_care/data/models/doctor_inapp.dart';
import 'package:happy_care/data/models/user.dart';
import 'package:happy_care/data/repositories/doctor_repository.dart';
import 'package:happy_care/data/socket/socket_io_service.dart';

enum DocStatus { loading, error, idle }

class DoctorController extends GetxController {
  List<User> listDoctor = [];
final DoctorRepository? _doctorRepository;
  final SocketIOService? _ioService;
  final status = DocStatus.idle.obs;
  List<DoctorInApp> listInApp = [];

  DoctorController(
      {SocketIOService? ioService, DoctorRepository? doctorRepository})
      : _doctorRepository = doctorRepository,
        _ioService = ioService;

  @override
  Future<void> onInit() async {
    super.onInit();
    status(DocStatus.loading);
    listDoctor = await getDoctorMaybeBySpecId(id: null);
    _ioService?.initService();
    await getDoctorOnline();
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
      await Future.delayed(Duration(minutes: 4));
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
            doctor.isOnline = true;
            break;
          } else {
            continue;
          }
        }
      }
      listDoctor.sort((a, b) => b.isOnline! ? 1 : -1);
    } else {
      for (var doctor in listDoctor) {
        doctor.isOnline = false;
      }
      return;
    }
  }
}
