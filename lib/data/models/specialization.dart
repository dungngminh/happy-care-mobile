class Specialization {
  Specialization({
    this.id,
    required this.name,
  });

  String? id;
  late String name;

  Specialization.init();

  factory Specialization.fromJson(Map<String, dynamic> json) => Specialization(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
