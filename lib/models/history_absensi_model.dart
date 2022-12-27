class HistoryAbsensiModel {
  int id;
  int employeeId;
  String date;
  DateTime checkIn;
  DateTime checkOut;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  HistoryAbsensiModel({
    required this.id,
    required this.employeeId,
    required this.date,
    required this.checkIn,
    required this.checkOut,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HistoryAbsensiModel.fromJson(Map<String, dynamic> json) {
    return HistoryAbsensiModel(
      id: json["id"],
      employeeId: json["employee_id"],
      date: json["date"],
      checkIn: DateTime.parse(json["check_in"]),
      checkOut: DateTime.parse(json["check_out"]),
      status: json["status"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }
}

class HistoryAbsensiSiswaModel {
  HistoryAbsensiSiswaModel({
    required this.studentAttendanceId,
    required this.gradeId,
    required this.studentId,
    required this.subjectId,
    required this.teacherId,
    required this.date,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.subjectName,
    required this.waktu,
  });

  int studentAttendanceId;
  int gradeId;
  int studentId;
  int subjectId;
  int teacherId;
  DateTime date;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String subjectName;
  String waktu;

  factory HistoryAbsensiSiswaModel.fromJson(Map<String, dynamic> json) =>
      HistoryAbsensiSiswaModel(
        studentAttendanceId: json["student_attendance_id"],
        gradeId: json["grade_id"],
        studentId: json["student_id"],
        subjectId: json["subject_id"],
        teacherId: json["teacher_id"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        subjectName: json["subject_name"],
        waktu: json["waktu"],
      );

  Map<String, dynamic> toJson() => {
        "student_attendance_id": studentAttendanceId,
        "grade_id": gradeId,
        "student_id": studentId,
        "subject_id": subjectId,
        "teacher_id": teacherId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "subject_name": subjectName,
        "waktu": waktu,
      };
}

class WeekAbsensiModel {
  String week;

  WeekAbsensiModel({
    required this.week,
  });

  factory WeekAbsensiModel.fromJson(Map<String, dynamic> json) {
    return WeekAbsensiModel(
      week: json["week"],
    );
  }
}

class WeekAbsensiPembelajaranModel {
  String week;
  int slider;

  WeekAbsensiPembelajaranModel({
    required this.week,
    required this.slider,
  });

  factory WeekAbsensiPembelajaranModel.fromJson(Map<String, dynamic> json) {
    return WeekAbsensiPembelajaranModel(
      week: json["week"],
      slider: json["slider"],
    );
  }
}

class HistoryAbsensiPembelajaranModel {
  int studentAttendanceId;
  int gradeId;
  int studentId;
  int subjectId;
  int teacherId;
  DateTime date;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String subjectName;
  String waktu;

  HistoryAbsensiPembelajaranModel({
    required this.studentAttendanceId,
    required this.gradeId,
    required this.studentId,
    required this.subjectId,
    required this.teacherId,
    required this.date,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.subjectName,
    required this.waktu,
  });

  factory HistoryAbsensiPembelajaranModel.fromJson(Map<String, dynamic> json) {
    return HistoryAbsensiPembelajaranModel(
      studentAttendanceId: json["student_attendance_id"],
      gradeId: json["grade_id"],
      studentId: json["student_id"],
      subjectId: json["subject_id"],
      teacherId: json["teacher_id"],
      date: DateTime.parse(json["date"]),
      status: json["status"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      subjectName: json["subject_name"],
      waktu: json["waktu"],
    );
  }
  Map<String, dynamic> toJson() => {
        "student_attendance_id": studentAttendanceId,
        "grade_id": gradeId,
        "student_id": studentId,
        "subject_id": subjectId,
        "teacher_id": teacherId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "subject_name": subjectName,
        "waktu": waktu,
      };
}



class StatisticModel {
  StatisticModel({
    required this.attend,
    required this.absence,
    required this.leave,
    required this.duty,
  });

  String attend;
  String absence;
  String leave;
  String duty;

  factory StatisticModel.fromJson(Map<String, dynamic> json) => StatisticModel(
        attend: json["attend"],
        absence: json["absence"],
        leave: json["leave"],
        duty: json["duty"],
      );

  Map<String, dynamic> toJson() => {
        "attend": attend,
        "absence": absence,
        "leave": leave,
        "duty": duty,
      };
}

class StatisticSiswaModel {
  StatisticSiswaModel({
    required this.attend,
    required this.absence,
    required this.sick,
    required this.izin,
  });

  String attend;
  String absence;
  String sick;
  String izin;

  factory StatisticSiswaModel.fromJson(Map<String, dynamic> json) =>
      StatisticSiswaModel(
        attend: json["attend"],
        absence: json["absence"],
        sick: json["sick"],
        izin: json["izin"],
      );

  Map<String, dynamic> toJson() => {
        "attend": attend,
        "absence": absence,
        "sick": sick,
        "izin": izin,
      };
}
