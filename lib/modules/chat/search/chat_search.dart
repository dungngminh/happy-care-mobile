import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_care/modules/chat/search/chat_search_controller.dart';

class ChatSearchScreen extends GetView<ChatSearchController> {
  const ChatSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Hello")));
  }
}
