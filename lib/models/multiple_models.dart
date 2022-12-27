class MultipleModels {
  MultipleModels({
    required this.books,
  });

  List<Book> books;

  factory MultipleModels.fromJson(Map<String, dynamic> json) => MultipleModels(
        books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
      };
}

class Book {
  Book({
    required this.gradeId,
    required this.studentId,
    required this.subjectId,
    required this.status,
  });

  int gradeId;
  int studentId;
  int subjectId;
  String status;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        gradeId: json["grade_id"],
        studentId: json["student_id"],
        subjectId: json["subject_id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "grade_id": gradeId,
        "student_id": studentId,
        "subject_id": subjectId,
        "status": status,
      };
}

class MultipleEkstraModels {
  MultipleEkstraModels({
    required this.books,
  });

  List<Books> books;

  factory MultipleEkstraModels.fromJson(Map<String, dynamic> json) =>
      MultipleEkstraModels(
        books: List<Books>.from(json["books"].map((x) => Books.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
      };
}

class Books {
  Books({
    required this.extracurricularId,
    required this.studentId,
    required this.status,
  });

  int extracurricularId;
  int studentId;
  String status;

  factory Books.fromJson(Map<String, dynamic> json) => Books(
        extracurricularId: json["extracurricular_id"],
        studentId: json["student_id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "extracurricular_id": extracurricularId,
        "student_id": studentId,
        "status": status,
      };
}
