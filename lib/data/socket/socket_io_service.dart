
import 'package:happy_care/core/utils/shared_pref.dart';
import 'package:happy_care/data/models/doctor_inapp.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter_dotenv/flutter_dotenv.dart';
class SocketIOService {
  late io.Socket socket;
  List<DoctorInApp>? listDoctor;

  Future<void> initService() async {
    socket = io.io(
        "${dotenv.env['DEV_URL']}",
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
    String token = await SharedPrefUtils.getStringKey('token');
    socket.onConnect((_) {
      socket.emitWithAck('join', token, ack: (data) {
        if (data != null) {
          print('from server $data');
        } else {
          print("Null");
        }
      });
    });
    getDoctorInApp();
  }

  getDoctorInApp() {
    socket.emitWithAck('get-doctors-in-app', "hello", ack: (data) {
      if (data != null) {
        print('===========GET DOCTOR IN APP=======\n$data');
        try {
          Iterable list = data["doctors"];
          listDoctor = list.map((e) => DoctorInApp.fromJson(e)).toList();
          print(listDoctor);
        } catch (_) {
          print("null call");
        }
      } else {
        print("===========NO DOCTOR IN APP=======\nNull");
      }
    });
    return null;
  }

  signOut() {
    socket.disconnect();
  }
}
