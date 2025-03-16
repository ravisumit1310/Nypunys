class ResultModel {
  final String student;
  final String admissionNo;
  final List<Results> results;

  ResultModel({
    required this.student,
    required this.admissionNo,
    required this.results,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      student: json['student'] ?? '',
      admissionNo: json['admission_no'] ?? '',
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => Results.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student': student,
      'admission_no': admissionNo,
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}

class Results {
  final String subject;
  final double marks; // Changed from int to double
  final double totalMarks; // Changed from int to double
  final double percentage; // Changed from int to double
  final String examDate;

  Results({
    required this.subject,
    required this.marks,
    required this.totalMarks,
    required this.percentage,
    required this.examDate,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      subject: json['subject'] ?? 'Unknown',
      marks: (json['marks'] as num?)?.toDouble() ??
          0.0, // Convert to double safely
      totalMarks: (json['total_marks'] as num?)?.toDouble() ??
          0.0, // Convert to double safely
      percentage: (json['percentage'] as num?)?.toDouble() ??
          0.0, // Convert to double safely
      examDate: json['exam_date'] ?? 'N/A',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'marks': marks,
      'total_marks': totalMarks,
      'percentage': percentage,
      'exam_date': examDate,
    };
  }
}
