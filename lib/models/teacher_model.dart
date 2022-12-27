class TeacherModel {
  TeacherModel({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
  });
  int employeeId;
  String firstName;
  String lastName;

  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
        employeeId: json["employee_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "first_name": firstName,
        "last_name": lastName,
      };
}
