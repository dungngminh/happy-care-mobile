class DoctorInApp {
  DoctorInApp({
    required this.id,
    required this.userId,
    required this.status,
  });

  String id;
  String userId;
  String status;

  factory DoctorInApp.fromJson(Map<String, dynamic> json) => DoctorInApp(
        id: json["id"],
        userId: json["userId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "status": status,
      };
}
