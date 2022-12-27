class DataBukuPerpusModel {
  DataBukuPerpusModel({
    required this.bookId,
    required this.bookCode,
    required this.bookName,
    required this.bookPrice,
    required this.bookCreator,
    required this.bookYear,
    required this.numberOfBook,
    required this.status,
    required this.date,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  int bookId;
  String bookCode;
  String bookName;
  String bookPrice;
  String bookCreator;
  String bookYear;
  String numberOfBook;
  String status;
  String date;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  factory DataBukuPerpusModel.fromJson(Map<String, dynamic> json) =>
      DataBukuPerpusModel(
        bookId: json["book_id"],
        bookCode: json["book_code"],
        bookName: json["book_name"],
        bookPrice: json["book_price"],
        bookCreator: json["book_creator"],
        bookYear: json["book_year"],
        numberOfBook: json["number_of_book"],
        status: json["status"],
        date: json["date"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "book_code": bookCode,
        "book_name": bookName,
        "book_price": bookPrice,
        "book_creator": bookCreator,
        "book_year": bookYear,
        "number_of_book": numberOfBook,
        "status": status,
        "date": date,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class DataBukuPenggunaPerpusModel {
  DataBukuPenggunaPerpusModel({
    required this.bookId,
    required this.bookCode,
    required this.bookName,
    required this.bookPrice,
    required this.numberOfBook,
    required this.status,
    required this.date,
    required this.image,
  });

  int bookId;
  String bookCode;
  String bookName;
  String bookPrice;
  String numberOfBook;
  String status;
  String date;
  String image;

  factory DataBukuPenggunaPerpusModel.fromJson(Map<String, dynamic> json) =>
      DataBukuPenggunaPerpusModel(
        bookId: json["book_id"],
        bookCode: json["book_code"],
        bookName: json["book_name"],
        bookPrice: json["book_price"],
        numberOfBook: json["number_of_book"],
        status: json["status"],
        date: json["date"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "book_code": bookCode,
        "book_name": bookName,
        "book_price": bookPrice,
        "number_of_book": numberOfBook,
        "status": status,
        "date": date,
        "image": image,
      };
}

class PengajuanBukuSiswaPerpusModel {
  PengajuanBukuSiswaPerpusModel({
    required this.loanBookId,
    required this.firstName,
    required this.lastName,
    required this.bookCode,
    required this.bookName,
    required this.bookPrice,
    required this.totalBook,
    required this.bookCreator,
    required this.bookYear,
    required this.status,
    required this.image,
    required this.nisn,
    required this.fromDate,
    required this.toDate,
    required this.statusLoan,
    required this.denda,
  });

  int loanBookId;
  String firstName;
  String lastName;
  String bookCode;
  String bookName;
  String bookPrice;
  String totalBook;
  String bookCreator;
  String bookYear;
  String status;
  String image;
  String nisn;
  DateTime fromDate;
  DateTime toDate;
  String statusLoan;
  int denda;

  factory PengajuanBukuSiswaPerpusModel.fromJson(Map<String, dynamic> json) =>
      PengajuanBukuSiswaPerpusModel(
        loanBookId: json["loan_book_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        bookCode: json["book_code"],
        bookName: json["book_name"],
        bookPrice: json["book_price"],
        totalBook: json["total_book"],
        bookCreator: json["book_creator"],
        bookYear: json["book_year"],
        status: json["status"],
        image: json["image"],
        nisn: json["nisn"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
        statusLoan: json["status_loan"],
        denda: json["denda"],
      );

  Map<String, dynamic> toJson() => {
        "loan_book_id": loanBookId,
        "first_name": firstName,
        "last_name": lastName,
        "book_code": bookCode,
        "book_name": bookName,
        "book_price": bookPrice,
        "total_book": totalBook,
        "book_creator": bookCreator,
        "book_year": bookYear,
        "status": status,
        "image": image,
        "nisn": nisn,
        "from_date": fromDate.toIso8601String(),
        "to_date": toDate.toIso8601String(),
        "status_loan": statusLoan,
        "denda": denda,
      };
}

class PengajuanBukuSiswaPerpusModel2 {
  PengajuanBukuSiswaPerpusModel2({
    required this.loanBookId,
    required this.firstName,
    required this.lastName,
    required this.bookCode,
    required this.bookName,
    // required this.bookPrice,
    required this.totalBook,
    required this.bookCreator,
    required this.bookYear,
    required this.status,
    required this.image,
    required this.nisn,
    required this.fromDate,
    required this.toDate,
    // required this.statusLoan,
    // required this.denda,
  });

  int loanBookId;
  String firstName;
  String lastName;
  String bookCode;
  String bookName;
  // String bookPrice;
  String totalBook;
  String bookCreator;
  String bookYear;
  String status;
  String image;
  String nisn;
  DateTime fromDate;
  DateTime toDate;
  // String statusLoan;
  // int denda;

  factory PengajuanBukuSiswaPerpusModel2.fromJson(Map<String, dynamic> json) =>
      PengajuanBukuSiswaPerpusModel2(
        loanBookId: json["loan_book_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        bookCode: json["book_code"],
        bookName: json["book_name"],
        // bookPrice: json["book_price"],
        totalBook: json["total_book"],
        bookCreator: json["book_creator"],
        bookYear: json["book_year"],
        status: json["status"],
        image: json["image"],
        nisn: json["nisn"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
        // statusLoan: json["status_loan"],
        // denda: json["denda"],
      );

  Map<String, dynamic> toJson() => {
        "loan_book_id": loanBookId,
        "first_name": firstName,
        "last_name": lastName,
        "book_code": bookCode,
        "book_name": bookName,
        // "book_price": bookPrice,
        "total_book": totalBook,
        "book_creator": bookCreator,
        "book_year": bookYear,
        "status": status,
        "image": image,
        "nisn": nisn,
        "from_date": fromDate.toIso8601String(),
        "to_date": toDate.toIso8601String(),
        // "status_loan": statusLoan,
        // "denda": denda,
      };
}

class RiwayatPengajuanBukuSiswaPerpusModel {
  RiwayatPengajuanBukuSiswaPerpusModel({
    required this.loanBookId,
    required this.firstName,
    required this.lastName,
    required this.bookCode,
    required this.bookName,
    required this.bookCreator,
    required this.bookYear,
    required this.totalBook,
    required this.status,
    required this.image,
    required this.nisn,
    required this.fromDate,
    required this.toDate,
  });

  int loanBookId;
  String firstName;
  String lastName;
  String bookCode;
  String bookName;
  String bookCreator;
  String bookYear;
  String totalBook;
  String status;
  String image;
  String nisn;
  DateTime fromDate;
  DateTime toDate;

  factory RiwayatPengajuanBukuSiswaPerpusModel.fromJson(
          Map<String, dynamic> json) =>
      RiwayatPengajuanBukuSiswaPerpusModel(
        loanBookId: json["loan_book_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        bookCode: json["book_code"],
        bookName: json["book_name"],
        bookCreator: json["book_creator"],
        bookYear: json["book_year"],
        totalBook: json["total_book"],
        status: json["status"],
        image: json["image"],
        nisn: json["nisn"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
      );

  Map<String, dynamic> toJson() => {
        "loan_book_id": loanBookId,
        "first_name": firstName,
        "last_name": lastName,
        "book_code": bookCode,
        "book_name": bookName,
        "book_creator": bookCreator,
        "book_year": bookYear,
        "total_book": totalBook,
        "status": status,
        "image": image,
        "nisn": nisn,
        "from_date": fromDate.toIso8601String(),
        "to_date": toDate.toIso8601String(),
      };
}

class PengajuanBukuPegawaiPerpusModel {
  PengajuanBukuPegawaiPerpusModel({
    required this.loanBookId,
    required this.firstName,
    required this.lastName,
    required this.bookCode,
    required this.bookName,
    required this.totalBook,
    required this.status,
    required this.bookcreator,
    required this.bookyear,
    required this.image,
    required this.nuptk,
    required this.fromDate,
    required this.toDate,
  });

  int loanBookId;
  String firstName;
  String lastName;
  String bookCode;
  String bookName;
  String totalBook;
  String status;
  String bookcreator;
  String bookyear;
  String image;
  String nuptk;
  DateTime fromDate;
  DateTime toDate;

  factory PengajuanBukuPegawaiPerpusModel.fromJson(Map<String, dynamic> json) =>
      PengajuanBukuPegawaiPerpusModel(
        loanBookId: json["loan_book_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        bookCode: json["book_code"],
        bookName: json["book_name"],
        totalBook: json["total_book"],
        status: json["status"],
        bookcreator: json["book_creator"],
        bookyear: json["book_year"],
        image: json["image"],
        nuptk: json["nuptk"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
      );

  Map<String, dynamic> toJson() => {
        "loan_book_id": loanBookId,
        "first_name": firstName,
        "last_name": lastName,
        "book_code": bookCode,
        "book_name": bookName,
        "total_book": totalBook,
        "status": status,
        "book_creator": bookcreator,
        "book_year": bookyear,
        "image": image,
        "nuptk": nuptk,
        "from_date": fromDate.toIso8601String(),
        "to_date": toDate.toIso8601String(),
      };
}

class PengajuanBukuPegawaiPerpusModel2 {
  PengajuanBukuPegawaiPerpusModel2({
    required this.loanBookId,
    required this.firstName,
    required this.lastName,
    required this.bookCode,
    required this.bookName,
    required this.bookPrice,
    required this.totalBook,
    required this.bookCreator,
    required this.bookYear,
    required this.status,
    required this.image,
    required this.nuptk,
    required this.fromDate,
    required this.toDate,
    required this.statusLoan,
    required this.denda,
  });

  int loanBookId;
  String firstName;
  String lastName;
  String bookCode;
  String bookName;
  String bookPrice;
  String totalBook;
  String bookCreator;
  String bookYear;
  String status;
  String image;
  String nuptk;
  DateTime fromDate;
  DateTime toDate;
  String statusLoan;
  int denda;

  factory PengajuanBukuPegawaiPerpusModel2.fromJson(
          Map<String, dynamic> json) =>
      PengajuanBukuPegawaiPerpusModel2(
        loanBookId: json["loan_book_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        bookCode: json["book_code"],
        bookName: json["book_name"],
        bookPrice: json["book_price"],
        totalBook: json["total_book"],
        bookCreator: json["book_creator"],
        bookYear: json["book_year"],
        status: json["status"],
        image: json["image"],
        nuptk: json["nuptk"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
        statusLoan: json["status_loan"],
        denda: json["denda"],
      );

  Map<String, dynamic> toJson() => {
        "loan_book_id": loanBookId,
        "first_name": firstName,
        "last_name": lastName,
        "book_code": bookCode,
        "book_name": bookName,
        "book_price": bookPrice,
        "total_book": totalBook,
        "book_creator": bookCreator,
        "book_year": bookYear,
        "status": status,
        "image": image,
        "nuptk": nuptk,
        "from_date": fromDate.toIso8601String(),
        "to_date": toDate.toIso8601String(),
        "status_loan": statusLoan,
        "denda": denda,
      };
}

class PengajuanBukuPegawaiPerpusModel1 {
  PengajuanBukuPegawaiPerpusModel1({
    required this.loanBookId,
    required this.bookId,
    required this.totalBook,
    required this.fromDate,
    required this.toDate,
    required this.bookCreator,
    required this.bookYear,
    required this.bookPrice,
    required this.date,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.bookCode,
    required this.bookName,
    required this.numberOfBook,
    required this.image,
    required this.denda,
  });

  int loanBookId;
  int bookId;
  String totalBook;
  DateTime fromDate;
  DateTime toDate;
  String bookCreator;
  String bookYear;
  String bookPrice;
  DateTime date;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String bookCode;
  String bookName;
  String numberOfBook;
  String image;
  int denda;

  factory PengajuanBukuPegawaiPerpusModel1.fromJson(
          Map<String, dynamic> json) =>
      PengajuanBukuPegawaiPerpusModel1(
        loanBookId: json["loan_book_id"],
        bookId: json["book_id"],
        totalBook: json["total_book"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
        bookCreator: json["book_creator"],
        bookYear: json["book_year"],
        bookPrice: json["book_price"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        bookCode: json["book_code"],
        bookName: json["book_name"],
        numberOfBook: json["number_of_book"],
        image: json["image"],
        denda: json["denda"],
      );

  Map<String, dynamic> toJson() => {
        "loan_book_id": loanBookId,
        "book_id": bookId,
        "total_book": totalBook,
        "from_date": fromDate.toIso8601String(),
        "to_date": toDate.toIso8601String(),
        "book_creator": bookCreator,
        "book_year": bookYear,
        "book_price": bookPrice,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "book_code": bookCode,
        "book_name": bookName,
        "number_of_book": numberOfBook,
        "image": image,
        "denda": denda,
      };
}

class SumbanganSiswaModel {
  SumbanganSiswaModel({
    required this.bookId,
    required this.firstName,
    required this.lastName,
    required this.nisn,
    required this.bookCode,
    required this.bookName,
    required this.bookPrice,
    required this.bookCreator,
    required this.bookYear,
    required this.numberOfBook,
    required this.status,
    required this.image,
  });

  int bookId;
  String firstName;
  String lastName;
  String nisn;
  String bookCode;
  String bookName;
  String bookPrice;
  String bookCreator;
  String bookYear;
  String numberOfBook;
  String status;
  dynamic image;

  factory SumbanganSiswaModel.fromJson(Map<String, dynamic> json) =>
      SumbanganSiswaModel(
        bookId: json["book_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        nisn: json["nisn"],
        bookCode: json["book_code"],
        bookName: json["book_name"],
        bookPrice: json["book_price"],
        bookCreator: json["book_creator"],
        bookYear: json["book_year"],
        numberOfBook: json["number_of_book"],
        status: json["status"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "first_name": firstName,
        "last_name": lastName,
        "nisn": nisn,
        "book_code": bookCode,
        "book_name": bookName,
        "book_price": bookPrice,
        "book_creator": bookCreator,
        "book_year": bookYear,
        "number_of_book": numberOfBook,
        "status": status,
        "image": image,
      };
}

class SumbanganPegawaiModel {
  SumbanganPegawaiModel({
    required this.bookId,
    required this.firstName,
    required this.lastName,
    required this.nuptk,
    required this.bookCode,
    required this.bookName,
    required this.bookPrice,
    required this.bookCreator,
    required this.bookYear,
    required this.numberOfBook,
    required this.status,
    required this.image,
  });

  int bookId;
  String firstName;
  String lastName;
  String nuptk;
  String bookCode;
  String bookName;
  String bookPrice;
  String bookCreator;
  String bookYear;
  String numberOfBook;
  String status;
  dynamic image;

  factory SumbanganPegawaiModel.fromJson(Map<String, dynamic> json) =>
      SumbanganPegawaiModel(
        bookId: json["book_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        nuptk: json["nuptk"],
        bookCode: json["book_code"],
        bookName: json["book_name"],
        bookPrice: json["book_price"],
        bookCreator: json["book_creator"],
        bookYear: json["book_year"],
        numberOfBook: json["number_of_book"],
        status: json["status"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "first_name": firstName,
        "last_name": lastName,
        "nuptk": nuptk,
        "book_code": bookCode,
        "book_name": bookName,
        "book_price": bookPrice,
        "book_creator": bookCreator,
        "book_year": bookYear,
        "number_of_book": numberOfBook,
        "status": status,
        "image": image,
      };
}

class QrCodeSiswaModel {
  QrCodeSiswaModel({
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.nisn,
    required this.jabatan,
    required this.image,
  });

  int studentId;
  String firstName;
  String lastName;
  String nisn;
  String jabatan;
  dynamic image;

  factory QrCodeSiswaModel.fromJson(Map<String, dynamic> json) =>
      QrCodeSiswaModel(
        studentId: json["student_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        nisn: json["nisn"],
        jabatan: json["jabatan"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "first_name": firstName,
        "last_name": lastName,
        "nisn": nisn,
        "jabatan": jabatan,
        "image": image,
      };
}

class QrCodePegawaiModel {
  QrCodePegawaiModel({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.nuptk,
    required this.jabatan,
    required this.image,
  });

  int employeeId;
  String firstName;
  String lastName;
  String nuptk;
  String jabatan;
  dynamic image;

  factory QrCodePegawaiModel.fromJson(Map<String, dynamic> json) =>
      QrCodePegawaiModel(
        employeeId: json["employee_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        nuptk: json["nuptk"],
        jabatan: json["jabatan"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "first_name": firstName,
        "last_name": lastName,
        "nuptk": nuptk,
        "jabatan": jabatan,
        "image": image,
      };
}

class RiwayatAbsensiPerpusSiswaModel {
  RiwayatAbsensiPerpusSiswaModel({
    required this.perpusAttendanceId,
    required this.studentId,
    required this.employeeId,
    required this.date,
    required this.absensi,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.nisn,
    required this.firstName,
    required this.lastName,
    required this.fatherName,
    required this.motherName,
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
    required this.motherEducation,
    required this.fatherEducation,
    required this.familyName,
    required this.familyAddress,
    required this.familyProfession,
    required this.extracurricularId,
    required this.image,
    required this.status,
  });

  int perpusAttendanceId;
  int studentId;
  dynamic employeeId;
  DateTime date;
  DateTime absensi;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;
  String nisn;
  String firstName;
  String lastName;
  String fatherName;
  String motherName;
  String gender;
  String phone;
  String placeOfBirth;
  DateTime dateOfBirth;
  DateTime dateSchoolNow;
  String address;
  String religion;
  String schoolOrigin;
  String schoolNow;
  String parentAddress;
  String motherProfession;
  String fatherProfession;
  String motherEducation;
  String fatherEducation;
  String familyName;
  String familyAddress;
  String familyProfession;
  int extracurricularId;
  String image;
  String status;

  factory RiwayatAbsensiPerpusSiswaModel.fromJson(Map<String, dynamic> json) =>
      RiwayatAbsensiPerpusSiswaModel(
        perpusAttendanceId: json["perpus_attendance_id"],
        studentId: json["student_id"],
        employeeId: json["employee_id"],
        date: DateTime.parse(json["date"]),
        absensi: DateTime.parse(json["absensi"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        nisn: json["nisn"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        fatherName: json["father_name"],
        motherName: json["mother_name"],
        gender: json["gender"],
        phone: json["phone"],
        placeOfBirth: json["place_of_birth"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        dateSchoolNow: DateTime.parse(json["date_school_now"]),
        address: json["address"],
        religion: json["religion"],
        schoolOrigin: json["school_origin"],
        schoolNow: json["school_now"],
        parentAddress: json["parent_address"],
        motherProfession: json["mother_profession"],
        fatherProfession: json["father_profession"],
        motherEducation: json["mother_education"],
        fatherEducation: json["father_education"],
        familyName: json["family_name"],
        familyAddress: json["family_address"],
        familyProfession: json["family_profession"],
        extracurricularId: json["extracurricular_id"],
        image: json["image"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "perpus_attendance_id": perpusAttendanceId,
        "student_id": studentId,
        "employee_id": employeeId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "absensi": absensi.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_id": userId,
        "nisn": nisn,
        "first_name": firstName,
        "last_name": lastName,
        "father_name": fatherName,
        "mother_name": motherName,
        "gender": gender,
        "phone": phone,
        "place_of_birth": placeOfBirth,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "date_school_now":
            "${dateSchoolNow.year.toString().padLeft(4, '0')}-${dateSchoolNow.month.toString().padLeft(2, '0')}-${dateSchoolNow.day.toString().padLeft(2, '0')}",
        "address": address,
        "religion": religion,
        "school_origin": schoolOrigin,
        "school_now": schoolNow,
        "parent_address": parentAddress,
        "mother_profession": motherProfession,
        "father_profession": fatherProfession,
        "mother_education": motherEducation,
        "father_education": fatherEducation,
        "family_name": familyName,
        "family_address": familyAddress,
        "family_profession": familyProfession,
        "extracurricular_id": extracurricularId,
        "image": image,
        "status": status,
      };
}

class RiwayatAbsensiPerpusPegawaiModel {
  RiwayatAbsensiPerpusPegawaiModel({
    required this.perpusAttendanceId,
    required this.studentId,
    required this.employeeId,
    required this.date,
    required this.absensi,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.nuptk,
    required this.npsn,
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.phone,
    required this.religion,
    required this.education,
    required this.familyName,
    required this.familyAddress,
    required this.position,
    required this.companyId,
    required this.workshiftId,
    required this.image,
  });

  int perpusAttendanceId;
  dynamic studentId;
  int employeeId;
  DateTime date;
  DateTime absensi;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;
  String firstName;
  String lastName;
  String nuptk;
  String npsn;
  String placeOfBirth;
  DateTime dateOfBirth;
  String gender;
  String address;
  String phone;
  String religion;
  String education;
  String familyName;
  String familyAddress;
  String position;
  int companyId;
  int workshiftId;
  String image;

  factory RiwayatAbsensiPerpusPegawaiModel.fromJson(
          Map<String, dynamic> json) =>
      RiwayatAbsensiPerpusPegawaiModel(
        perpusAttendanceId: json["perpus_attendance_id"],
        studentId: json["student_id"],
        employeeId: json["employee_id"],
        date: DateTime.parse(json["date"]),
        absensi: DateTime.parse(json["absensi"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        nuptk: json["nuptk"],
        npsn: json["npsn"],
        placeOfBirth: json["place_of_birth"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        gender: json["gender"],
        address: json["address"],
        phone: json["phone"],
        religion: json["religion"],
        education: json["education"],
        familyName: json["family_name"],
        familyAddress: json["family_address"],
        position: json["position"],
        companyId: json["company_id"],
        workshiftId: json["workshift_id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "perpus_attendance_id": perpusAttendanceId,
        "student_id": studentId,
        "employee_id": employeeId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "absensi": absensi.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "nuptk": nuptk,
        "npsn": npsn,
        "place_of_birth": placeOfBirth,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "address": address,
        "phone": phone,
        "religion": religion,
        "education": education,
        "family_name": familyName,
        "family_address": familyAddress,
        "position": position,
        "company_id": companyId,
        "workshift_id": workshiftId,
        "image": image,
      };
}
