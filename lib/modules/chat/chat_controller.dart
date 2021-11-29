import 'package:get/get.dart';
import 'package:happy_care/data/models/room_chat/room_chat.dart';
import 'package:happy_care/data/repositories/room_repository.dart';
import 'package:happy_care/data/socket/socket_io_service.dart';
import 'package:happy_care/modules/user/user_controller.dart';

enum Statuss { loading, error, idle }

class ChatController extends GetxController {
  final SocketIOService? socketService;
  final RoomRepository? roomRepository;
  final UserController userController = Get.find();
  final listRoom = RxList<RoomChat>([]);
  final status = Statuss.idle.obs;

  ChatController({this.socketService, this.roomRepository});

  @override
  Future<void> onInit() async {
    super.onInit();
    status(Statuss.loading);
    await loadMyRooms();
  }

  Future<void> loadMyRooms() async {
    await roomRepository!.getMyRoom().then((room) {
      listRoom(room!.where((element) => element.haveMessage == true).toList());
      print(listRoom.toString());
      status(Statuss.idle);
    }).onError((error, stackTrace) {
      print(error);
      status(Statuss.error);
    });
  }

  joinToChatRoom({required String doctorId}) async {
    bool result = await roomRepository!.checkRoomIfExist(
        userId: userController.user.value.id, doctorId: doctorId);
    return result;
  }
}
