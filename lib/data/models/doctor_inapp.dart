class DoctorInApp {
  DoctorInApp({
    required this.id,
    required this.userId,
    required this.userRole,
    required this.status,
  });

  String id;
  String userId;
  String status;
  String userRole;

  factory DoctorInApp.fromJson(Map<String, dynamic> json) => DoctorInApp(
        id: json["id"],
        userId: json["userId"],
        userRole: json["userRole"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "userRole": userRole,
        "status": status,
      };
}
