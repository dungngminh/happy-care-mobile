import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:happy_care/core/utils/shared_pref.dart';
import 'package:happy_care/data/models/doctor_inapp.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketIOService {
  io.Socket? socket;
  List<DoctorInApp> listDoctor = [];

  /// init SocketIO Service
  Future<void> initService() async {
    socket = io.io(
        "${dotenv.env['BASE_URL']}",
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .enableForceNew()
            .build());
    socket!.connect();
    String token = await SharedPrefUtils.getStringKey('token');
    print(token);
    socket!.onConnect((_) {
      socket!.emitWithAck('join', token, ack: (data) {
        if (data != null) {
          print('from server $data');
        } else {
          print("Null");
        }
      });
    });
  }

  ///Get all Doctor activity in app
  getDoctorInApp() {
    socket!.emitWithAck('get-doctors-in-app', "hello", ack: (data) {
      if (data["message"] != 'cannot found any doctors') {
        print('===========GET DOCTOR IN APP=======\n$data');
        try {
          Iterable list = data["data"]["doctors"];
          listDoctor = list.map((e) => DoctorInApp.fromJson(e)).toList();
          print(listDoctor);
        } catch (_) {
          print("===========NO DOCTOR IN APP=======\nNull");
          print("null call");
          listDoctor == [];
        }
      } else {
        print("===========NO DOCTOR IN APP=======\nNull");
        listDoctor == [];
      }
    });
  }

  ///disconnect socket when sign out
  signOut() {
    socket!.disconnect();
  }

  ///emit event join room
  joinToRoom({required String roomId, required String userId}) {
    Map<String, String> msg = {"roomId": roomId, "userId": userId};
    socket!.emitWithAck('join-chat-room', msg, ack: (data) {
      if (data != 'joined room $roomId') {
        print(data);
      } else {
        print(data);
      }
    });
  }

  ///emit event send message
  sendMessage({
    required dynamic content,
    required String roomId,
    required String userId,
    required String contentType,
  }) {
    Map<String, dynamic> msg = {
      "content": content,
      "roomId": roomId,
      "type": contentType,
      "userId": userId
    };
    print(msg);
    if (msg["contentType"] == "image") {
      socket!.emitWithAck('send-message', msg, binary: true, ack: (data) {
        print("send mess data: $data");
      });
    } else {
      socket!.emitWithAck('send-message', msg, ack: (data) {
        print("send mess data: $data");
      });
    }
  }

  ///emit event leave chat room
  leaveChatRoom({required String roomId}) {
    Map<String, String> msg = {
      "roomId": roomId,
    };
    print("leaving");
    socket!.emitWithAck('leave-chat-room', msg, ack: (data) {
      print("leave chat room data: $data");
    });
  }

  isTypingAction(
      {required String roomId,
      required String userId,
      required bool isTyping}) {
    print(isTyping);
    Map<String, dynamic> msg = {
      "roomId": roomId,
      "userId": userId,
      "isTyping": isTyping,
    };
    socket!.emitWithAck('typing-message', msg, ack: (data) {
      print(data);
    });
  }
}
