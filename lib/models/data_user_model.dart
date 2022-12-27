class DataSiswaModel {
  DataSiswaModel({
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.nisn,
    required this.email,
    required this.role,
  });

  int studentId;
  String firstName;
  String lastName;
  String nisn;
  String email;
  String role;

  factory DataSiswaModel.fromJson(Map<String, dynamic> json) => DataSiswaModel(
        studentId: json["student_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        nisn: json["nisn"],
        email: json["email"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "first_name": firstName,
        "last_name": lastName,
        "nisn": nisn,
        "email": email,
        "role": role,
      };
}

class DataPegawaiModel {
  DataPegawaiModel({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.nuptk,
    required this.email,
    required this.role,
  });

  int employeeId;
  String firstName;
  String lastName;
  String nuptk;
  String email;
  String role;

  factory DataPegawaiModel.fromJson(Map<String, dynamic> json) =>
      DataPegawaiModel(
        employeeId: json["employee_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        nuptk: json["nuptk"],
        email: json["email"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "first_name": firstName,
        "last_name": lastName,
        "nuptk": nuptk,
        "email": email,
        "role": role,
      };
}
