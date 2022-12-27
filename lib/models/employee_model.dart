class EmployeeModel {
  EmployeeModel({
    required this.employeeId,
    required this.nuptk,
    required this.firstName,
    required this.lastName,
    // required this.nik,
    required this.npsn,
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.gender,
    required this.religion,
    required this.address,
    required this.education,
    required this.familyName,
    required this.familyAddress,
    required this.position,
    required this.image,
    required this.status,
    required this.isWali,
    required this.extracurricularid,
    required this.extracurricular,
  });

  int employeeId;
  String nuptk;
  String firstName;
  String lastName;
  // String nik;
  String npsn;
  String placeOfBirth;
  String dateOfBirth;
  String gender;
  String religion;
  String address;
  String education;
  String familyName;
  String familyAddress;
  String position;
  dynamic image;
  String status;
  String isWali;
  int extracurricularid;
  String extracurricular;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        employeeId: json["employee_id"],
        nuptk: json["nuptk"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        // nik: json["nik"],
        npsn: json["npsn"],
        placeOfBirth: json["place_of_birth"],
        dateOfBirth: json["date_of_birth"],
        gender: json["gender"],
        religion: json["religion"],
        address: json["address"],
        education: json["education"],
        familyName: json["family_name"],
        familyAddress: json["family_address"],
        position: json["position"],
        image: json["image"],
        status: json["status"],
        isWali: json["isWali"],
        extracurricularid: json["extracurricular_id"],
        extracurricular: json["extracurricular"],
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "nuptk": nuptk,
        "first_name": firstName,
        "last_name": lastName,
        // "nik": nik,
        "npsn": npsn,
        "place_of_birth": placeOfBirth,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "religion": religion,
        "address": address,
        "education": education,
        "family_name": familyName,
        "family_address": familyAddress,
        "position": position,
        "image": image,
        "status": status,
        "isWali": isWali,
        "extracurricular_id": extracurricularid,
        "extracurricular": extracurricular,
      };
}

class EmployeeData {
  EmployeeData({
    required this.employeeId,
    required this.userId,
    required this.firstName,
    required this.lastName,
    // required this.nik,
    required this.nuptk,
    required this.npsn,
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.phone,
    required this.education,
    required this.religion,
    required this.familyAddress,
    required this.familyName,
    required this.position,
    required this.image,
  });

  int employeeId;
  int userId;
  String firstName;
  String lastName;
  // String nik;
  String nuptk;
  String npsn;
  String placeOfBirth;
  String dateOfBirth;
  String gender;
  String address;
  String phone;
  String education;
  String religion;
  String familyAddress;
  String familyName;
  String position;
  String image;

  factory EmployeeData.fromJson(Map<String, dynamic> json) => EmployeeData(
        employeeId: json["employee_id"],
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        // nik: json["nik"],
        nuptk: json["nuptk"],
        npsn: json["npsn"],
        placeOfBirth: json["place_of_birth"],
        dateOfBirth: json["date_of_birth"],
        gender: json["gender"],
        address: json["address"],
        phone: json["phone"],
        education: json["education"],
        religion: json["religion"],
        familyAddress: json["family_address"],
        familyName: json["family_name"],
        position: json["position"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        // "nik": nik,
        "nuptk": nuptk,
        "npsn": npsn,
        "place_of_birth": placeOfBirth,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "address": address,
        "phone": phone,
        "education": education,
        "religion": religion,
        "family_address": familyAddress,
        "family_name": familyName,
        "position": position,
        "image": image,
      };
}
