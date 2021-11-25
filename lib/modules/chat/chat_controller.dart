import 'package:get/get.dart';
import 'package:happy_care/data/socket/socket_io_service.dart';

class ChatController extends GetxController {
  final SocketIOService? socketService;
  ChatController({this.socketService});

  @override
  Future<void> onInit() async {
    super.onInit();
    await socketService?.initService();
  }

  void pressRandom() {
    print("press");
  }
}
