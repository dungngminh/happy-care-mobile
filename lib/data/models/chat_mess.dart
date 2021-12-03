import 'dart:convert';

class ChatMess {
  String? content;
  String? type;
  String? time;
  String? user;
  String? room;

  ChatMess({
    this.content,
    this.type,
    this.time,
    this.user,
    this.room,
  });

  @override
  String toString() {
    return 'ChatMess(content: $content, type: $type, time: $time, user: $user, room: $room)';
  }

  factory ChatMess.fromMap(Map<String, dynamic> data) => ChatMess(
        content: data['content'] as String?,
        type: data['type'] as String?,
        time: data['time'] as String?,
        user: data['user'] as String?,
        room: data['room'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'content': content,
        'type': type,
        'time': time,
        'user': user,
        'room': room,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ChatMess].
  factory ChatMess.fromJson(String data) {
    return ChatMess.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ChatMess] to a JSON string.
  String toJson() => json.encode(toMap());
}
