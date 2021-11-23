import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketIOService {
  late io.Socket socket;

  // static final SocketIOService _instance = SocketIOService._internal();
  // factory SocketIOService() {
  //   return _instance;
  // }
  // SocketIOService._internal();

  void initService() {
    socket = io.io(
        "${dotenv.env['DEV_URL']}",
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
  }
}
