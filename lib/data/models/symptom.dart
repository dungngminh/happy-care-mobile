class Symptom {
  String? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? v;

  Symptom({this.id, this.name, this.createdAt, this.updatedAt, this.v});

  @override
  String toString() {
    return 'Symptom(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  factory Symptom.fromJson(Map<String, dynamic> json) => Symptom(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v,
      };
}
