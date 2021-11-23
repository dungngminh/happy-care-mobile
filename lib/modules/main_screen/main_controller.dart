import 'package:get/get.dart';
import 'package:happy_care/data/services/socket_io_service.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;
  final String role = "";

  void changeCurrentIndex(int newIndex) {
    currentIndex.value = newIndex;
  }

  final SocketIOService socketService = SocketIOService();

  @override
  void onInit() {
    socketService.initService();
    super.onInit();
  }
}
