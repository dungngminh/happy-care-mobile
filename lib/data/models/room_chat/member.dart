import 'dart:convert';

import 'profile.dart';

class Member {
  String? id;
  Profile? profile;

  Member({this.id, this.profile});

  @override
  String toString() => 'Member(id: $id, profile: $profile)';

  factory Member.fromMap(Map<String, dynamic> data) => Member(
        id: data['_id'] as String?,
        profile: data['profile'] == null
            ? null
            : Profile.fromMap(data['profile'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'profile': profile?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Member].
  factory Member.fromJson(String data) {
    return Member.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Member] to a JSON string.
  String toJson() => json.encode(toMap());
}
