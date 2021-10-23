class User {
  late String id;
  late String email;
  late String role;
  ProfileUser? profileUser;

  User.init();
  User(
      {required this.id,
      required this.email,
      required this.role,
      this.profileUser});

  User.fromJson(Map<String, dynamic> json) {
    profileUser =
        json['profile'] != null ? ProfileUser.fromJson(json['profile']) : null;
    id = json['_id'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profileUser != null) {
      data['profile'] = profileUser!.toJson();
    }
    data['_id'] = id;
    data['email'] = email;
    data['role'] = role;
    return data;
  }
}

class ProfileUser {
  String? fullName;
  int? age;
  String? phone;
  String? address;
  String? avatarUrl;

  ProfileUser({
    this.fullName,
    this.age,
    this.phone,
    this.address,
  });

  ProfileUser.fromJson(Map<String, dynamic> json) {
    fullName = json['fullname'];
    age = json['age'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = fullName;
    data['age'] = age;
    data['phone'] = phone;
    data['address'] = address;
    return data;
  }
}
