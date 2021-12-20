class Specialization {
  Specialization({
    this.id,
    required this.name,
    this.description,
  });

  String? id;
  late String name;
  String? description;

  Specialization.init();

  factory Specialization.fromJson(Map<String, dynamic> json) => Specialization(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
      };
}
