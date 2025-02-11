import 'dart:convert';

class NotificationModel {
  final int id;
  final int receiverId;
  final String? className;
  final String? admissionNo;
  final String message;
  final String createdAt;
  final int senderId;
  final String receiverType;
  final String senderType;
  final String? section;
  final String title;
  final int seenCount;

  NotificationModel({
    required this.id,
    required this.receiverId,
    this.className,
    this.admissionNo,
    required this.message,
    required this.createdAt,
    required this.senderId,
    required this.receiverType,
    required this.senderType,
    this.section,
    required this.title,
    required this.seenCount,
  });

  // Factory constructor to create a NotificationModel from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      receiverId: json['receiver_id'],
      className: json['class_name'],
      admissionNo: json['admission_no'],
      message: json['message'],
      createdAt: json['created_at'],
      senderId: json['sender_id'],
      receiverType: json['receiver_type'],
      senderType: json['sender_type'],
      section: json['section'],
      title: json['title'],
      seenCount: json['seen_count'],
    );
  }

  // Convert NotificationModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'receiver_id': receiverId,
      'class_name': className,
      'admission_no': admissionNo,
      'message': message,
      'created_at': createdAt,
      'sender_id': senderId,
      'receiver_type': receiverType,
      'sender_type': senderType,
      'section': section,
      'title': title,
      'seen_count': seenCount,
    };
  }

  // Convert list of JSON objects into List<NotificationModel>
  static List<NotificationModel> fromJsonList(String jsonString) {
    final data = jsonDecode(jsonString);
    return (data['notifications'] as List)
        .map((json) => NotificationModel.fromJson(json))
        .toList();
  }
}
