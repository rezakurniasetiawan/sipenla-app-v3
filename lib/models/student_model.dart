class StudentModel {
  StudentModel({
    required this.studentId,
    required this.nisn,
    // required this.nik,
    required this.studentFirstName,
    required this.studentLastName,
    required this.fatherName,
    required this.motherName,
    required this.gender,
    required this.phone,
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.address,
    required this.religion,
    required this.image,
    required this.gradeId,
    required this.gradeName,
    required this.employeeFirstName,
    required this.employeeLastName,
    required this.extracurricularId,
    required this.extracurricularName,
    required this.status,
    required this.StatusStudent,
  });

  int studentId;
  String nisn;
  // String nik;
  String studentFirstName;
  String studentLastName;
  String fatherName;
  String motherName;
  String gender;
  String phone;
  String placeOfBirth;
  String dateOfBirth;
  String address;
  String religion;
  dynamic image;
  int gradeId;
  String gradeName;
  String employeeFirstName;
  String employeeLastName;
  int extracurricularId;
  String extracurricularName;
  String status;
  String StatusStudent;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        studentId: json["student_id"],
        nisn: json["nisn"],
        // nik: json["nik"],
        studentFirstName: json["student_first_name"],
        studentLastName: json["student_last_name"],
        fatherName: json["father_name"],
        motherName: json["mother_name"],
        gender: json["gender"],
        phone: json["phone"],
        placeOfBirth: json["place_of_birth"],
        dateOfBirth: json["date_of_birth"],
        address: json["address"],
        religion: json["religion"],
        image: json["image"],
        gradeId: json["grade_id"],
        gradeName: json["grade_name"],
        employeeFirstName: json["employee_first_name"],
        employeeLastName: json["employee_last_name"],
        extracurricularId: json["extracurricular_id"],
        extracurricularName: json["extracurricular_name"],
        status: json["status"],
        StatusStudent: json["status_student"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "nisn": nisn,
        // "nik": nik,
        "student_first_name": studentFirstName,
        "student_last_name": studentLastName,
        "father_name": fatherName,
        "mother_name": motherName,
        "gender": gender,
        "phone": phone,
        "place_of_birth": placeOfBirth,
        "date_of_birth": dateOfBirth,
        "address": address,
        "religion": religion,
        "image": image,
        "grade_id": gradeId,
        "grade_name": gradeName,
        "employee_first_name": employeeFirstName,
        "employee_last_name": employeeLastName,
        "extracurricular_id": extracurricularId,
        "extracurricular_name": extracurricularName,
        "status": status,
        "status_student": StatusStudent,
      };
}

class StudentDataModel {
  StudentDataModel({
    required this.studentId,
    required this.userId,
    required this.nisn,
    // required this.nik,
    required this.firstName,
    required this.lastName,
    required this.motherName,
    required this.fatherName,
    required this.gender,
    required this.phone,
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.dateSchoolNow,
    required this.address,
    required this.religion,
    required this.schoolOrigin,
    required this.schoolNow,
    required this.parentAddress,
    required this.motherProfession,
    required this.fatherProfession,
    required this.fatherEducation,
    required this.motherEducation,
    required this.familyName,
    required this.familyAddress,
    required this.familyProfession,
    required this.image,
  });

  int studentId;
  int userId;
  String nisn;
  // String nik;
  String firstName;
  String lastName;
  String motherName;
  String fatherName;
  String gender;
  String phone;
  String placeOfBirth;
  String dateOfBirth;
  String dateSchoolNow;
  String address;
  String religion;
  String schoolOrigin;
  String schoolNow;
  String parentAddress;
  String motherProfession;
  String fatherProfession;
  String fatherEducation;
  String motherEducation;
  String familyName;
  String familyAddress;
  String familyProfession;
  dynamic image;

  factory StudentDataModel.fromJson(Map<String, dynamic> json) =>
      StudentDataModel(
        studentId: json["student_id"],
        userId: json["user_id"],
        nisn: json["nisn"],
        // nik: json["nik"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        motherName: json["mother_name"],
        fatherName: json["father_name"],
        gender: json["gender"],
        phone: json["phone"],
        placeOfBirth: json["place_of_birth"],
        dateOfBirth: json["date_of_birth"],
        dateSchoolNow: json["date_school_now"],
        address: json["address"],
        religion: json["religion"],
        schoolOrigin: json["school_origin"],
        schoolNow: json["school_now"],
        parentAddress: json["parent_address"],
        motherProfession: json["mother_profession"],
        fatherProfession: json["father_profession"],
        fatherEducation: json["father_education"],
        motherEducation: json["mother_education"],
        familyName: json["family_name"],
        familyAddress: json["family_address"],
        familyProfession: json["family_profession"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "user_id": userId,
        "nisn": nisn,
        // "nik": nik,
        "first_name": firstName,
        "last_name": lastName,
        "mother_name": motherName,
        "father_name": fatherName,
        "gender": gender,
        "phone": phone,
        "place_of_birth": placeOfBirth,
        "date_of_birth": dateOfBirth,
        "date_school_now": dateSchoolNow,
        "address": address,
        "religion": religion,
        "school_origin": schoolOrigin,
        "school_now": schoolNow,
        "parent_address": parentAddress,
        "mother_profession": motherProfession,
        "father_profession": fatherProfession,
        "father_education": fatherEducation,
        "mother_education": motherEducation,
        "family_name": familyName,
        "family_address": familyAddress,
        "family_profession": familyProfession,
        "image": image,
      };
}
