import 'package:get/get.dart';
import 'package:happy_care/data/models/room_chat/room_chat.dart';
import 'package:happy_care/data/models/room_chat/room_chat_pass.dart';
import 'package:happy_care/data/models/user.dart';
import 'package:happy_care/data/repositories/mess_repository.dart';
import 'package:happy_care/data/repositories/room_repository.dart';
import 'package:happy_care/data/services/my_cloudinary_service.dart';
import 'package:happy_care/data/services/socket_io_service.dart';
import 'package:happy_care/modules/user/user_controller.dart';
import 'package:happy_care/routes/app_pages.dart';

enum ChatStatus { loading, error, idle }

class ChatController extends GetxController {
  final SocketIOService? socketService;
  final RoomRepository? roomRepository;
  final MyCloudinaryService? cloudinaryService;
  final MessRepository? messRepository;
  final UserController userController = Get.find();
  // DoctorController? doctorController;
  final listRoom = RxList<RoomChat?>([]);
  final listUserChatWithByRoom = RxList<User>([]);
  final status = ChatStatus.idle.obs;
  ChatController(
      {this.messRepository,
      this.socketService,
      this.roomRepository,
      this.cloudinaryService});

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadMyRooms();
  }

  Future<void> loadMyRooms() async {
    status(ChatStatus.loading);
    await roomRepository!.getMyRoom().then((room) async {
      listRoom(room.where((element) => element!.hasMessages == true).toList());
      print(listRoom.toString());
      listUserChatWithByRoom.clear();
      for (var room in listRoom) {
        if (userController.user.value.role == "member") {
          listUserChatWithByRoom.add(await getUserById(room!.members![1].id!));
        } else {
          listUserChatWithByRoom.add(await getUserById(room!.members![0].id!));
        }
      }
      await getNewMessages();
      status(ChatStatus.idle);
    }).onError((error, stackTrace) {
      status(ChatStatus.error);
    });
  }

  Future<void> getNewMessages() async {
    if (listRoom.isNotEmpty) {
      for (var room in listRoom) {
        await messRepository!
            .getMessageHistory(roomId: room!.id!, limit: 1)
            .then((value) {
          print("dadad");
          room.newestMessage = value.first.content;
        });
      }
    }
  }

  Future<String?> joinFirstToChatRoom({required String notUserId}) async {
    String? roomId;
    if (userController.user.value.role == 'doctor') {
      roomId = await roomRepository!.checkRoomIfExist(
          memberId: notUserId, doctorId: userController.user.value.id);
    } else {
      roomId = await roomRepository!.checkRoomIfExist(
          memberId: userController.user.value.id, doctorId: notUserId);
    }
    socketService!
        .joinToRoom(roomId: roomId!, userId: userController.user.value.id);
    return roomId;
  }

  joinExistChatRoom(
      {required String roomId, required User userChatWithId}) async {
    socketService!
        .joinToRoom(roomId: roomId, userId: userController.user.value.id);
    bool result = await Get.toNamed(AppRoutes.rChatRoom,
        arguments: RoomChatPass(roomId, userChatWithId));
    if (result) {
      await getNewMessages();
    }
  }

  Future<User> getUserById(String userId) async {
    return await userController.userRepository!.getUserById(userId);
  }
}
