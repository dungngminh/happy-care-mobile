import 'dart:convert';

import 'member.dart';

class RoomChat {
  String? id;
  String? name;
  List<Member>? members;
  bool? isRead;
  bool? haveMessage;
  RoomChat({this.id, this.name, this.members, this.isRead, this.haveMessage});

  @override
  String toString() {
    return 'RoomChat(id: $id, name: $name, members: $members, isRead: $isRead, haveMessage: $haveMessage)';
  }

  factory RoomChat.fromJson(Map<String, dynamic> data) => RoomChat(
      id: data['_id'] as String?,
      name: data['name'] as String?,
      members: (data['members'] as List<dynamic>?)
          ?.map((e) => Member.fromMap(e as Map<String, dynamic>))
          .toList(),
      isRead: data['isRead'] as bool?,
      haveMessage: data['haveMessage'] as bool?);

  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name,
        'members': members?.map((e) => e.toMap()).toList(),
        'isRead': isRead,
        'haveMessage': haveMessage,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RoomChat].
  /// `dart:convert`
  ///
  /// Converts [RoomChat] to a JSON string.
  String toJson() => json.encode(toMap());
}
