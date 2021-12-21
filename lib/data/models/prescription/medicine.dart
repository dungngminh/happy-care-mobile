class Medicine {
  String? drug;
  String? dosage;
  String? id;

  Medicine({this.drug, this.dosage, this.id});

  @override
  String toString() => 'Medicine(drug: $drug, dosage: $dosage, id: $id)';

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        drug: json['drug'] as String?,
        dosage: json['dosage'] as String?,
        id: json['_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'drug': drug,
        'dosage': dosage,
        '_id': id,
      };
}
