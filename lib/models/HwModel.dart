class Homework {
  final int? homeworkId;
  final String? subject;
  final String? description;
  final String? assignedDate;
  final String? status;
  final int? marks;

  Homework({
    this.homeworkId,
    this.subject,
    this.description,
    this.assignedDate,
    this.status,
    this.marks,
  });

  factory Homework.fromJson(Map<String, dynamic> json) {
    return Homework(
      homeworkId: json['homework_id'],
      subject: json['subject'],
      description: json['description'],
      assignedDate: json['assigned_date'],
      status: json['status'],
      marks: json['marks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'homework_id': homeworkId,
      'subject': subject,
      'description': description,
      'assigned_date': assignedDate,
      'status': status,
      'marks': marks,
    };
  }
}
