class KelasModel {
  KelasModel({
    required this.gradeId,
    required this.gradeName,
  });

  int gradeId;
  String gradeName;

  factory KelasModel.fromJson(Map<String, dynamic> json) => KelasModel(
        gradeId: json["grade_id"],
        gradeName: json["grade_name"],
      );

  Map<String, dynamic> toJson() => {
        "grade_id": gradeId,
        "grade_name": gradeName,
      };
}

class JadwalModel {
  JadwalModel({
    required this.lessonScheduleId,
    required this.dayName,
    required this.subjectName,
    required this.startTime,
    required this.endTime,
    required this.firstName,
    required this.lastName,
    required this.daysId,
    required this.subjectId,
    required this.teacherId,
  });
  int lessonScheduleId;
  String dayName;
  String subjectName;
  String startTime;
  String endTime;
  String firstName;
  String lastName;
  int daysId;
  int subjectId;
  int teacherId;

  factory JadwalModel.fromJson(Map<String, dynamic> json) => JadwalModel(
        lessonScheduleId: json["lesson_schedule_id"],
        dayName: json["day_name"],
        subjectName: json["subject_name"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        daysId: json["days_id"],
        subjectId: json["subject_id"],
        teacherId: json["teacher_id"],
      );

  Map<String, dynamic> toJson() => {
        "lesson_schedule_id": lessonScheduleId,
        "day_name": dayName,
        "subject_name": subjectName,
        "start_time": startTime,
        "end_time": endTime,
        "first_name": firstName,
        "last_name": lastName,
        "days_id": daysId,
        "subject_id": subjectId,
        "teacher_id": teacherId,
      };
}

class JadwalGuruModel {
  JadwalGuruModel({
    required this.dayName,
    required this.gradeName,
    required this.startTime,
    required this.endTime,
    required this.subjectName,
  });
  String dayName;
  String gradeName;
  String startTime;
  String endTime;
  String subjectName;

  factory JadwalGuruModel.fromJson(Map<String, dynamic> json) =>
      JadwalGuruModel(
        dayName: json["day_name"],
        gradeName: json["grade_name"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        subjectName: json["subject_name"],
      );

  Map<String, dynamic> toJson() => {
        "day_name": dayName,
        "grade_name": gradeName,
        "start_time": startTime,
        "end_time": endTime,
        "subject_name": subjectName,
      };
}

class EkstraModel {
  EkstraModel({
    required this.extracurricularId,
    required this.extracurricularName,
  });

  int extracurricularId;
  String extracurricularName;

  factory EkstraModel.fromJson(Map<String, dynamic> json) => EkstraModel(
        extracurricularId: json["extracurricular_id"],
        extracurricularName: json["extracurricular_name"],
      );

  Map<String, dynamic> toJson() => {
        "extracurricular_id": extracurricularId,
        "extracurricular_name": extracurricularName,
      };
}

class JadwalEkstraModel {
  JadwalEkstraModel({
    required this.extraSchedulesId,
    required this.dayName,
    required this.extracurricularName,
    required this.startTime,
    required this.endTime,
    required this.firstName,
    required this.lastName,
    required this.daysId,
    required this.extracurricularId,
    required this.teacherId,
  });

  int extraSchedulesId;
  String dayName;
  String extracurricularName;
  String startTime;
  String endTime;
  String firstName;
  String lastName;
  int daysId;
  int extracurricularId;
  int teacherId;

  factory JadwalEkstraModel.fromJson(Map<String, dynamic> json) =>
      JadwalEkstraModel(
        extraSchedulesId: json["extra_schedules_id"],
        dayName: json["day_name"],
        extracurricularName: json["extracurricular_name"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        daysId: json["days_id"],
        extracurricularId: json["extracurricular_id"],
        teacherId: json["teacher_id"],
      );

  Map<String, dynamic> toJson() => {
        "extra_schedules_id": extraSchedulesId,
        "day_name": dayName,
        "extracurricular_name": extracurricularName,
        "start_time": startTime,
        "end_time": endTime,
        "first_name": firstName,
        "last_name": lastName,
        "days_id": daysId,
        "extracurricular_id": extracurricularId,
        "teacher_id": teacherId,
      };
}

class JadwalKerjaModel {
  JadwalKerjaModel({
    required this.workdaysId,
    required this.dayName,
    required this.shiftName,
    required this.startTime,
    required this.endTime,
    required this.workshiftId,
    required this.daysId,
    required this.employeeId,
    required this.firstName,
    required this.lastName,
  });
  int workdaysId;
  String dayName;
  String shiftName;
  String startTime;
  String endTime;
  int workshiftId;
  int daysId;
  int employeeId;
  String firstName;
  String lastName;

  factory JadwalKerjaModel.fromJson(Map<String, dynamic> json) =>
      JadwalKerjaModel(
        workdaysId: json["workdays_id"],
        dayName: json["day_name"],
        shiftName: json["shift_name"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        workshiftId: json["workshift_id"],
        daysId: json["days_id"],
        employeeId: json["employee_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "workdays_id": workdaysId,
        "day_name": dayName,
        "shift_name": shiftName,
        "start_time": startTime,
        "end_time": endTime,
        "workshift_id": workshiftId,
        "days_id": daysId,
        "employee_id": employeeId,
        "first_name": firstName,
        "last_name": lastName,
      };
}

class JadwalKerjaPegawaiModel {
  JadwalKerjaPegawaiModel({
    required this.dayName,
    required this.firstName,
    required this.lastName,
    required this.startTime,
    required this.endTime,
  });
  String dayName;
  String firstName;
  String lastName;
  String startTime;
  String endTime;

  factory JadwalKerjaPegawaiModel.fromJson(Map<String, dynamic> json) =>
      JadwalKerjaPegawaiModel(
        dayName: json["day_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "day_name": dayName,
        "first_name": firstName,
        "last_name": lastName,
        "start_time": startTime,
        "end_time": endTime,
      };
}
