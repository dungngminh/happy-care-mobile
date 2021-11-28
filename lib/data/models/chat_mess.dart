class ChatMess {
  final String id;
  final String content;
  final DateTime time;
  final String user;
  final String roomId;
  final bool status;

  ChatMess({
    required this.id,
    required this.content,
    required this.time,
    required this.user,
    required this.roomId,
    required this.status,
  });

  // factory ChatMess.fromJson(Map<String, dynamic> json){
  //   return ChatMess(id )
  // }
}
