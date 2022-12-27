class StudentAll {
  final String studentId;
  final String firstName;
  final String lastName;

  StudentAll({
    required this.studentId,
    required this.firstName,
    required this.lastName,
  });

  factory StudentAll.fromJson(Map<String, dynamic> json) {
    return StudentAll(
      studentId: json["student_id"],
      firstName: json["first_name"].toString(),
      lastName: json["last_name"].toString(),
    );
  }
}
