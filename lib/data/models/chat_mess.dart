class ChatMess {
  final String content;
  final DateTime time;
  final String user;
  final String roomId;
  final bool status;

  ChatMess({
    required this.content,
    required this.time,
    required this.user,
    required this.roomId,
    required this.status,
  });
}
