class AttendanceModel {
  final int studentId;
  final int totalSchoolDays;
  final int totalPresent;
  final int totalLate;
  final int totalAbsent;
  final List<String> absentDates;
  final List<String> lateDates;

  AttendanceModel({
    required this.studentId,
    required this.totalSchoolDays,
    required this.totalPresent,
    required this.totalLate,
    required this.totalAbsent,
    required this.absentDates,
    required this.lateDates,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      studentId: json['student_id'] ?? 0,
      totalSchoolDays: json['total_school_days'] ?? 0,
      totalPresent: json['total_present'] ?? 0,
      totalLate: json['total_late'] ?? 0,
      totalAbsent: json['total_absent'] ?? 0,
      absentDates: (json['absent_dates'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      lateDates: (json['late_dates'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}
