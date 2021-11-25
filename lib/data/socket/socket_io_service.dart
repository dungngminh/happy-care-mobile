import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:happy_care/core/utils/shared_pref.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketIOService {
  late io.Socket socket;

  // static final SocketIOService _instance = SocketIOService._internal();
  // factory SocketIOService() {
  //   return _instance;
  // }
  // SocketIOService._internal();

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
        print('ack $data');
        if (data != null) {
          print('from server $data');
        } else {
          print("Null");
        }
      });
    });
  }
}
