class ChatMess {
  final String content;
  final String user;
  final String? time;

  ChatMess({
    required this.content,
    required this.user,
    this.time,
  });

  factory ChatMess.fromJson(Map<String, dynamic> json) => ChatMess(
        content: json['message'],
        user: json['user'],
        time: json['time'],
      );
}
