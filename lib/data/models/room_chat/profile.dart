import 'dart:convert';

class Profile {
  String? fullname;

  Profile({this.fullname});

  @override
  String toString() => 'Profile(fullname: $fullname)';

  factory Profile.fromMap(Map<String, dynamic> data) => Profile(
        fullname: data['fullname'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'fullname': fullname,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Profile].
  factory Profile.fromJson(String data) {
    return Profile.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Profile] to a JSON string.
  String toJson() => json.encode(toMap());
}
