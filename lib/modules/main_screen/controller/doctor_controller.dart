import 'package:get/get.dart';
import 'package:happy_care/data/models/doctor_inapp.dart';
import 'package:happy_care/data/models/user.dart';
import 'package:happy_care/data/repositories/doctor_repository.dart';
import 'package:happy_care/data/socket/socket_io_service.dart';

enum Status { loading, error, idle }

class DoctorController extends GetxController {
  List<User> listDoctor = [];
  final DoctorRepository? _doctorRepository;
  final SocketIOService? _ioService;
  final status = Status.loading.obs;
  List<DoctorInApp>? listInApp = [];

  DoctorController(
      {SocketIOService? ioService, DoctorRepository? doctorRepository})
      : _doctorRepository = doctorRepository,
        _ioService = ioService;

  @override
  Future<void> onInit() async {
    super.onInit();
    listDoctor = await getDoctorMaybeBySpecId(id: null);
    _ioService?.initService();
    await Future.delayed(Duration(seconds: 3)).then((value) {
      status(Status.idle);
      listInApp = _ioService?.listDoctor;
    }).catchError((_) {
      status(Status.error);
    });
    checkOnlineAndSort();
    update();
  }

  Future<List<User>> getDoctorMaybeBySpecId({String? id}) async {
    listDoctor = await _doctorRepository!.getDoctorMaybeBySpecId(specId: id);
    checkOnlineAndSort();
    return listDoctor;
  }

  void checkOnlineAndSort() {
    if (listInApp != null) {
      for (var doctor in listDoctor) {
        for (var inApp in listInApp!) {
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
      return;
    }
  }
}
