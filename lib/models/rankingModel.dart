class StudentRank {
  final int? rank;
  final String? studentName;
  final double? totalMarks;

  StudentRank({
    this.rank,
    this.studentName,
    this.totalMarks,
  });

  factory StudentRank.fromJson(Map<String, dynamic> json) {
    return StudentRank(
      rank: json['rank'],
      studentName: json['student_name'],
      totalMarks: json['total_marks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'student_name': studentName,
      'total_marks': totalMarks,
    };
  }
}
