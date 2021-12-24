class Drug {
  String? id;
  String? name;
  String? description;


  Drug({this.id, this.name, this.description});

  @override
  String toString() {
    return 'Drug(id: $id, name: $name, description: $description)';
  }

  factory Drug.fromJson(Map<String, dynamic> json) => Drug(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
      };
}
