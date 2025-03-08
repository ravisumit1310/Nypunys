import 'dart:convert';

TtModel ttModelFromJson(String str) => TtModel.fromJson(json.decode(str));

String ttModelToJson(TtModel data) => json.encode(data.toJson());

class TtModel {
  String status;
  List<Timetable> timetable;

  TtModel({
    required this.status,
    required this.timetable,
  });

  factory TtModel.fromJson(Map<String, dynamic> json) => TtModel(
        status: json["status"],
        timetable: List<Timetable>.from(
            json["timetable"].map((x) => Timetable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "timetable": List<dynamic>.from(timetable.map((x) => x.toJson())),
      };
}

class Timetable {
  String day;
  int classId;
  String period2;
  String period4;
  String period6;
  String? period8;
  String period1;
  int id;
  String period3;
  String period5;
  String? period7;
  String section;

  Timetable({
    required this.day,
    required this.classId,
    required this.period2,
    required this.period4,
    required this.period6,
    required this.period8,
    required this.period1,
    required this.id,
    required this.period3,
    required this.period5,
    required this.period7,
    required this.section,
  });

  factory Timetable.fromJson(Map<String, dynamic> json) => Timetable(
        day: json["day"],
        classId: json["class_id"],
        period2: json["period2"],
        period4: json["period4"],
        period6: json["period6"],
        period8: json["period8"],
        period1: json["period1"],
        id: json["id"],
        period3: json["period3"],
        period5: json["period5"],
        period7: json["period7"],
        section: json["section"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "class_id": classId,
        "period2": period2,
        "period4": period4,
        "period6": period6,
        "period8": period8,
        "period1": period1,
        "id": id,
        "period3": period3,
        "period5": period5,
        "period7": period7,
        "section": section,
      };
}
