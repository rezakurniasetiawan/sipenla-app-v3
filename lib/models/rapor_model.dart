class DetailNilaiSiswaModel {
  DetailNilaiSiswaModel({
    required this.firstName,
    required this.lastName,
    required this.mapel,
    required this.nilaiTugas1,
    required this.nilaiTugas2,
    required this.nilaiTugas3,
    required this.nilaiTugas4,
    required this.nilaiUh1,
    required this.nilaiUh2,
    required this.nilaiUh3,
    required this.nilaiUh4,
    required this.nilaiUts,
    required this.nilaiUas,
    required this.nilaiFix,
  });

  String firstName;
  String lastName;
  String mapel;
  int nilaiTugas1;
  int nilaiTugas2;
  int nilaiTugas3;
  int nilaiTugas4;
  int nilaiUh1;
  int nilaiUh2;
  int nilaiUh3;
  int nilaiUh4;
  int nilaiUts;
  int nilaiUas;
  double nilaiFix;

  factory DetailNilaiSiswaModel.fromJson(Map<String, dynamic> json) =>
      DetailNilaiSiswaModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        mapel: json["mapel"],
        nilaiTugas1: json["nilaiTugas1"],
        nilaiTugas2: json["nilaiTugas2"],
        nilaiTugas3: json["nilaiTugas3"],
        nilaiTugas4: json["nilaiTugas4"],
        nilaiUh1: json["nilaiUH1"],
        nilaiUh2: json["nilaiUH2"],
        nilaiUh3: json["nilaiUH3"],
        nilaiUh4: json["nilaiUH4"],
        nilaiUts: json["nilaiUTS"],
        nilaiUas: json["nilaiUAS"],
        nilaiFix: json["nilaiFix"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "mapel": mapel,
        "nilaiTugas1": nilaiTugas1,
        "nilaiTugas2": nilaiTugas2,
        "nilaiTugas3": nilaiTugas3,
        "nilaiTugas4": nilaiTugas4,
        "nilaiUH1": nilaiUh1,
        "nilaiUH2": nilaiUh2,
        "nilaiUH3": nilaiUh3,
        "nilaiUH4": nilaiUh4,
        "nilaiUTS": nilaiUts,
        "nilaiUAS": nilaiUas,
        "nilaiFix": nilaiFix,
      };
}

class DataKelasKepsekModel {
  DataKelasKepsekModel({
    required this.gradeId,
    required this.gradeName,
  });

  int gradeId;
  String gradeName;

  factory DataKelasKepsekModel.fromJson(Map<String, dynamic> json) =>
      DataKelasKepsekModel(
        gradeId: json["grade_id"],
        gradeName: json["grade_name"],
      );

  Map<String, dynamic> toJson() => {
        "grade_id": gradeId,
        "grade_name": gradeName,
      };
}

class NilaiRaporSiswa {
  NilaiRaporSiswa({
    required this.subjectName,
    required this.nilaiFix,
  });

  String subjectName;
  double nilaiFix;

  factory NilaiRaporSiswa.fromJson(Map<String, dynamic> json) =>
      NilaiRaporSiswa(
        subjectName: json["subject_name"],
        nilaiFix: json["nilai_fix"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "subject_name": subjectName,
        "nilai_fix": nilaiFix,
      };
}

class NilaiEkstraSiswa {
  NilaiEkstraSiswa({
    required this.extracurricularName,
    required this.nilai,
  });

  String extracurricularName;
  int nilai;

  factory NilaiEkstraSiswa.fromJson(Map<String, dynamic> json) =>
      NilaiEkstraSiswa(
        extracurricularName: json["extracurricular_name"],
        nilai: json["nilai"]
      );

  Map<String, dynamic> toJson() => {
        "extracurricular_name": extracurricularName,
        "nilai": nilai,
      };
}

class RiwayatKepsekModel {
  RiwayatKepsekModel({
    required this.gradeName,
    required this.semesterName,
    required this.academicYear,
    required this.status,
  });

  String gradeName;
  String semesterName;
  String academicYear;
  String status;

  factory RiwayatKepsekModel.fromJson(Map<String, dynamic> json) => RiwayatKepsekModel(
        gradeName: json["grade_name"],
        semesterName: json["semester_name"],
        academicYear: json["academic_year"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "grade_name": gradeName,
        "semester_name": semesterName,
        "academic_year": academicYear,
        "status": status,
      };
}
