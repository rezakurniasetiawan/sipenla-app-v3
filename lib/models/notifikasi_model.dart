class NotifikasiModel {
  NotifikasiModel({
    required this.id,
    required this.studentId,
    required this.title,
    required this.notifType,
    required this.message,
    required this.sendTime,
    required this.readStamp,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int studentId;
  String title;
  String notifType;
  String message;
  DateTime sendTime;
  dynamic readStamp;
  DateTime createdAt;
  DateTime updatedAt;

  factory NotifikasiModel.fromJson(Map<String, dynamic> json) =>
      NotifikasiModel(
        id: json["id"],
        studentId: json["student_id"],
        title: json["title"],
        notifType: json["notif_type"],
        message: json["message"],
        sendTime: DateTime.parse(json["send_time"]),
        readStamp: json["read_stamp"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "title": title,
        "notif_type": notifType,
        "message": message,
        "send_time": sendTime.toIso8601String(),
        "read_stamp": readStamp,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
