import 'dart:async';

import 'package:happy_care/data/models/doctor_inapp.dart';

class SocketEventStream {
  final _socketStream = StreamController<DoctorInApp>();

  void Function(DoctorInApp) get addResponse => _socketStream.sink.add;

  Stream<DoctorInApp> get getResponse => _socketStream.stream;

   void dispose(){
    _socketStream.close();
  }
}
