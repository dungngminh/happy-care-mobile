class DoctorInApp {
  DoctorInApp({
    required this.id,
    required this.userId,
    required this.userRole,
    required this.status,
  });

  String id;
  String userId;
  int status;
  String userRole;

  factory DoctorInApp.fromJson(Map<String, dynamic> json) => DoctorInApp(
        id: json["id"],
        userId: json["userId"],
        userRole: json["userRole"],
        status:
            json["status"] == "busy" ? 1 : (json["status"] == "online" ? 2 : 0),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "userRole": userRole,
        "status": status,
      };
}
