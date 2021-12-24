import 'medicine.dart';

class Prescription {
  String? id;
  String? diagnose;
  List<Medicine>? medicines;
  String? member;
  String? doctor;
  String? date;
  String? note;

  Prescription({
    this.id,
    this.diagnose,
    this.medicines,
    this.member,
    this.doctor,
    this.date,
    this.note,
  });

  @override
  String toString() {
    return 'Prescription(id: $id, diagnose: $diagnose, medicines: $medicines, member: $member, doctor: $doctor, date: $date, note: $note)';
  }

  factory Prescription.fromJson(Map<String, dynamic> json) => Prescription(
        id: json['_id'] as String?,
        diagnose: json['diagnose'] as String?,
        medicines: (json['medicines'] as List<dynamic>?)
            ?.map((e) => Medicine.fromJson(e as Map<String, dynamic>))
            .toList(),
        member: json['member'] as String?,
        doctor: json['doctor'] as String?,
        date: json['date'] as String?,
        note: json['note'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'diagnose': diagnose,
        'medicines': medicines?.map((e) => e.toJson()).toList(),
        'member': member,
        'doctor': doctor,
        'date': date,
        'note': note,
      };
}
