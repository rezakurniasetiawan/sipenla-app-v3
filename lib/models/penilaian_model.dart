class PenilaianStudentModel {
  PenilaianStudentModel({
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.nisn,
  });

  int studentId;
  String firstName;
  String lastName;
  String nisn;

  factory PenilaianStudentModel.fromJson(Map<String, dynamic> json) =>
      PenilaianStudentModel(
        studentId: json["Student"]["student_id"],
        firstName: json["Student"]["first_name"],
        lastName: json["Student"]["last_name"],
        nisn: json["Student"]["nisn"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "first_name": firstName,
        "last_name": lastName,
        "nisn": nisn,
      };
}

class MappingPenilaianStudent {
  MappingPenilaianStudent({
    required this.books,
  });

  List<BookPenilaian> books;

  factory MappingPenilaianStudent.fromJson(Map<String, dynamic> json) =>
      MappingPenilaianStudent(
        books: List<BookPenilaian>.from(
            json["books"].map((x) => BookPenilaian.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
      };
}

class BookPenilaian {
  BookPenilaian({
    required this.studentId,
    required this.gradeId,
    required this.subjectId,
    required this.semesterId,
    required this.assessmentId,
    required this.academicYearId,
    required this.nilai,
  });

  int studentId;
  int gradeId;
  int subjectId;
  int semesterId;
  int assessmentId;
  int academicYearId;
  int nilai;

  factory BookPenilaian.fromJson(Map<String, dynamic> json) => BookPenilaian(
        studentId: json["student_id"],
        gradeId: json["grade_id"],
        subjectId: json["subject_id"],
        semesterId: json["semester_id"],
        assessmentId: json["assessment_id"],
        academicYearId: json["academic_year_id"],
        nilai: json["nilai"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "grade_id": gradeId,
        "subject_id": subjectId,
        "semester_id": semesterId,
        "assessment_id": assessmentId,
        "academic_year_id": academicYearId,
        "nilai": nilai,
      };
}

class NilaiStudentModel {
  NilaiStudentModel({
    required this.penilaianId,
    required this.nisn,
    required this.firstName,
    required this.lastName,
    required this.nilai,
  });

  int penilaianId;
  String nisn;
  String firstName;
  String lastName;
  int nilai;

  factory NilaiStudentModel.fromJson(Map<String, dynamic> json) =>
      NilaiStudentModel(
        penilaianId: json["penilaian_id"],
        nisn: json["nisn"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        nilai: json["nilai"],
      );

  Map<String, dynamic> toJson() => {
        "penilaian_id": penilaianId,
        "nisn": nisn,
        "first_name": firstName,
        "last_name": lastName,
        "nilai": nilai,
      };
}

class NilaiEkstraStudentModel {
  NilaiEkstraStudentModel({
    required this.penilaianextraid,
    required this.nisn,
    required this.firstName,
    required this.lastName,
    required this.nilai,
  });

  int penilaianextraid;
  String nisn;
  String firstName;
  String lastName;
  int nilai;

  factory NilaiEkstraStudentModel.fromJson(Map<String, dynamic> json) =>
      NilaiEkstraStudentModel(
        penilaianextraid: json["penilaian_extra_id"],
        nisn: json["nisn"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        nilai: json["nilai"],
      );

  Map<String, dynamic> toJson() => {
        "penilaian_extra_id": penilaianextraid,
        "nisn": nisn,
        "first_name": firstName,
        "last_name": lastName,
        "nilai": nilai,
      };
}

class RiwayatNilaiSiswaModel {
  RiwayatNilaiSiswaModel({
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

  factory RiwayatNilaiSiswaModel.fromJson(Map<String, dynamic> json) =>
      RiwayatNilaiSiswaModel(
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
      };
}

class PenilaianEkstrStudentModel {
  PenilaianEkstrStudentModel({
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.nisn,
  });

  int studentId;
  String firstName;
  String lastName;
  String nisn;

  factory PenilaianEkstrStudentModel.fromJson(Map<String, dynamic> json) =>
      PenilaianEkstrStudentModel(
        studentId: json["student_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        nisn: json["nisn"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "first_name": firstName,
        "last_name": lastName,
        "nisn": nisn,
      };
}

class MappingPenilaianEkstraModel {
  MappingPenilaianEkstraModel({
    required this.books,
  });

  List<BookEkstra> books;

  factory MappingPenilaianEkstraModel.fromJson(Map<String, dynamic> json) =>
      MappingPenilaianEkstraModel(
        books: List<BookEkstra>.from(
            json["books"].map((x) => BookEkstra.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
      };
}

class BookEkstra {
  BookEkstra({
    required this.studentId,
    required this.extracurricularId,
    required this.semesterId,
    required this.academicYearId,
    required this.nilai,
  });

  int studentId;
  int extracurricularId;
  int semesterId;
  int academicYearId;
  int nilai;

  factory BookEkstra.fromJson(Map<String, dynamic> json) => BookEkstra(
        studentId: json["student_id"],
        extracurricularId: json["extracurricular_id"],
        semesterId: json["semester_id"],
        academicYearId: json["academic_year_id"],
        nilai: json["nilai"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "extracurricular_id": extracurricularId,
        "semester_id": semesterId,
        "academic_year_id": academicYearId,
        "nilai": nilai,
      };
}
