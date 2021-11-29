import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:happy_care/core/utils/shared_pref.dart';
import 'package:happy_care/data/models/doctor_inapp.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketIOService {
  late io.Socket socket;
  List<DoctorInApp>? listDoctor;

  Future<void> initService() async {
    socket = io.io(
        "${dotenv.env['DEV_URL']}",
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect().enableForceNewConnection()
            .build());
    socket.connect();
    String token = await SharedPrefUtils.getStringKey('token');
    print(token);
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
      if (data != 'cannot found any doctors') {
        print('===========GET DOCTOR IN APP=======\n$data');
        try {
          Iterable list = data["doctors"];
          listDoctor = list.map((e) => DoctorInApp.fromJson(e)).toList();
          print(listDoctor);
        } catch (_) {
          print("null call");
          listDoctor == null;
        }
      } else {
        print("===========NO DOCTOR IN APP=======\nNull");
        listDoctor == null;
      }
    });
  }

  signOut() {
    socket.disconnect();
  }
}
