class AbsensiSiswaModel {
  AbsensiSiswaModel({
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.nisn,
    required this.status,
  });
  int studentId;
  String firstName;
  String lastName;
  String nisn;
  String status;

  factory AbsensiSiswaModel.fromJson(Map<String, dynamic> json) =>
      AbsensiSiswaModel(
        studentId: json["absensi"]["student_id"],
        firstName: json["absensi"]["first_name"],
        lastName: json["absensi"]["last_name"],
        nisn: json["absensi"]["nisn"],
        status: json["status"],
      );

}

class SiswaKonfirmasiPenilaianModel {
  SiswaKonfirmasiPenilaianModel({
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.nisn,

  });
  int studentId;
  String firstName;
  String lastName;
  String nisn;

  factory SiswaKonfirmasiPenilaianModel.fromJson(Map<String, dynamic> json) =>
      SiswaKonfirmasiPenilaianModel(
        studentId: json["Student"]["student_id"],
        firstName: json["Student"]["first_name"],
        lastName: json["Student"]["last_name"],
        nisn: json["Student"]["nisn"],

      );

}
