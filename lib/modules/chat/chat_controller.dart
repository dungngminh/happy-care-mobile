import 'package:get/get.dart';
import 'package:happy_care/data/repositories/room_repository.dart';
import 'package:happy_care/data/repositories/user_repository.dart';
import 'package:happy_care/data/socket/socket_io_service.dart';
import 'package:happy_care/modules/user/user_controller.dart';

class ChatController extends GetxController {
  final SocketIOService? socketService;
  final RoomRepository? roomRepository;

  final UserController userController = Get.find();

  ChatController({this.socketService, this.roomRepository});

  joinToChatRoom({required String doctorId}) async {
    bool result = await roomRepository!.checkRoomIfExist(
        userId: userController.user.value.id, doctorId: doctorId);
    return result;
  }
}
