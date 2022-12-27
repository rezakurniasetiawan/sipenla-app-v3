class FasilitasModel {
  FasilitasModel({
    required this.facilityId,
    required this.facilityCode,
    required this.facilityName,
    required this.numberOfFacility,
    required this.year,
    required this.status,
    required this.date,
    required this.image,
  });

  int facilityId;
  String facilityCode;
  String facilityName;
  String numberOfFacility;
  String year;
  String status;
  String date;
  dynamic image;

  factory FasilitasModel.fromJson(Map<String, dynamic> json) => FasilitasModel(
        facilityId: json["facility_id"],
        facilityCode: json["facility_code"],
        facilityName: json["facility_name"],
        numberOfFacility: json["number_of_facility"],
        year: json["year"],
        status: json["status"],
        date: json["date"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "facility_id": facilityId,
        "facility_code": facilityCode,
        "facility_name": facilityName,
        "number_of_facility": numberOfFacility,
        "year": year,
        "status": status,
        "date": date,
        "image": image,
      };
}

class PengajuanFasilitasModel {
  PengajuanFasilitasModel({
    required this.books,
  });

  List<Bookss> books;

  factory PengajuanFasilitasModel.fromJson(Map<String, dynamic> json) =>
      PengajuanFasilitasModel(
        books: List<Bookss>.from(json["books"].map((x) => Bookss.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
      };
}

class Bookss {
  Bookss({
    required this.facilityId,
    required this.totalFacility,
    required this.fromDate,
    required this.toDate,
  });

  int facilityId;
  int totalFacility;
  int fromDate;
  int toDate;

  factory Bookss.fromJson(Map<String, dynamic> json) => Bookss(
        facilityId: json["facility_id"],
        totalFacility: json["total_facility"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
      );

  Map<String, dynamic> toJson() => {
        "facility_id": facilityId,
        "total_facility": totalFacility,
        "from_date": fromDate,
        "to_date": toDate,
      };
}

class PengajuanFasilitasMappingModel {
  PengajuanFasilitasMappingModel({
    required this.books,
  });

  List<Booksss> books;

  factory PengajuanFasilitasMappingModel.fromJson(Map<String, dynamic> json) =>
      PengajuanFasilitasMappingModel(
        books:
            List<Booksss>.from(json["books"].map((x) => Booksss.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
      };
}

class Booksss {
  Booksss({
    required this.facilityId,
    required this.totalFacility,
    required this.fromDate,
    required this.toDate,
    required this.nameFas,
    required this.codeFas,
    required this.imageFas,
  });

  int facilityId;
  int totalFacility;
  int fromDate;
  int toDate;
  String nameFas;
  String codeFas;
  String imageFas;

  factory Booksss.fromJson(Map<String, dynamic> json) => Booksss(
        facilityId: json["facility_id"],
        totalFacility: json["total_facility"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        nameFas: json["name_fas"],
        codeFas: json["code_fas"],
        imageFas: json["image_fas"],
      );

  Map<String, dynamic> toJson() => {
        "facility_id": facilityId,
        "total_facility": totalFacility,
        "from_date": fromDate,
        "to_date": toDate,
        "name_fas": nameFas,
        "code_fas": codeFas,
        "image_fas": imageFas,
      };
}

class PengembalianFasilitasModel {
  PengembalianFasilitasModel({
    required this.loanFacilityId,
    required this.facilityId,
    required this.totalFacility,
    required this.fromDate,
    required this.toDate,
    required this.date,
    required this.status,
    required this.employeeId,
    required this.studentId,
    required this.createdAt,
    required this.updatedAt,
    required this.facilityCode,
    required this.facilityName,
    required this.numberOfFacility,
    required this.year,
    required this.ownedBy,
    required this.image,
  });

  int loanFacilityId;
  int facilityId;
  String totalFacility;
  DateTime fromDate;
  DateTime toDate;
  DateTime date;
  String status;
  int employeeId;
  dynamic studentId;
  DateTime createdAt;
  DateTime updatedAt;
  String facilityCode;
  String facilityName;
  String numberOfFacility;
  String year;
  String ownedBy;
  String image;

  factory PengembalianFasilitasModel.fromJson(Map<String, dynamic> json) =>
      PengembalianFasilitasModel(
        loanFacilityId: json["loan_facility_id"],
        facilityId: json["facility_id"],
        totalFacility: json["total_facility"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
        date: DateTime.parse(json["date"]),
        status: json["status"],
        employeeId: json["employee_id"],
        studentId: json["student_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        facilityCode: json["facility_code"],
        facilityName: json["facility_name"],
        numberOfFacility: json["number_of_facility"],
        year: json["year"],
        ownedBy: json["owned_by"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "loan_facility_id": loanFacilityId,
        "facility_id": facilityId,
        "total_facility": totalFacility,
        "from_date": fromDate.toIso8601String(),
        "to_date": toDate.toIso8601String(),
        "date": date.toIso8601String(),
        "status": status,
        "employee_id": employeeId,
        "student_id": studentId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "facility_code": facilityCode,
        "facility_name": facilityName,
        "number_of_facility": numberOfFacility,
        "year": year,
        "owned_by": ownedBy,
        "image": image,
      };
}

class AprrovePeminjamanSiswaModel {
  AprrovePeminjamanSiswaModel({
    required this.loanFacilityId,
    required this.firstName,
    required this.lastName,
    required this.facilityCode,
    required this.facilityName,
    required this.totalFacility,
    required this.images,
    required this.status,
    required this.nisn,
    required this.fromDate,
    required this.toDate,
  });

  int loanFacilityId;
  String firstName;
  String lastName;
  String facilityCode;
  String facilityName;
  String totalFacility;
  String images;
  String status;
  String nisn;
  DateTime fromDate;
  DateTime toDate;

  factory AprrovePeminjamanSiswaModel.fromJson(Map<String, dynamic> json) =>
      AprrovePeminjamanSiswaModel(
        loanFacilityId: json["loan_facility_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        facilityCode: json["facility_code"],
        facilityName: json["facility_name"],
        totalFacility: json["total_facility"],
        images: json["image"],
        status: json["status"],
        nisn: json["nisn"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
      );

  Map<String, dynamic> toJson() => {
        "loan_facility_id": loanFacilityId,
        "first_name": firstName,
        "last_name": lastName,
        "facility_code": facilityCode,
        "facility_name": facilityName,
        "total_facility": totalFacility,
        "image": images,
        "status": status,
        "nisn": nisn,
        "from_date": fromDate.toIso8601String(),
        "to_date": toDate.toIso8601String(),
      };
}

class AprrovePeminjamanPegawaiModel {
  AprrovePeminjamanPegawaiModel({
    required this.loanFacilityId,
    required this.firstName,
    required this.lastName,
    required this.facilityCode,
    required this.facilityName,
    required this.totalFacility,
    required this.images,
    required this.status,
    required this.nuptk,
    required this.fromDate,
    required this.toDate,
  });

  int loanFacilityId;
  String firstName;
  String lastName;
  String facilityCode;
  String facilityName;
  String totalFacility;
  String images;
  String status;
  String nuptk;
  DateTime fromDate;
  DateTime toDate;

  factory AprrovePeminjamanPegawaiModel.fromJson(Map<String, dynamic> json) =>
      AprrovePeminjamanPegawaiModel(
        loanFacilityId: json["loan_facility_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        facilityCode: json["facility_code"],
        facilityName: json["facility_name"],
        totalFacility: json["total_facility"],
        images: json["image"],
        status: json["status"],
        nuptk: json["nuptk"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
      );

  Map<String, dynamic> toJson() => {
        "loan_facility_id": loanFacilityId,
        "first_name": firstName,
        "last_name": lastName,
        "facility_code": facilityCode,
        "facility_name": facilityName,
        "total_facility": totalFacility,
        "image": images,
        "status": status,
        "nuptk": nuptk,
        "from_date": fromDate.toIso8601String(),
        "to_date": toDate.toIso8601String(),
      };
}

class RiwayatSiswaFasilitasModel {
  RiwayatSiswaFasilitasModel({
    required this.firstName,
    required this.lastName,
    required this.facilityCode,
    required this.facilityName,
    required this.totalFacility,
    required this.status,
    required this.date,
  });

  String firstName;
  String lastName;
  String facilityCode;
  String facilityName;
  String totalFacility;
  String status;
  String date;

  factory RiwayatSiswaFasilitasModel.fromJson(Map<String, dynamic> json) =>
      RiwayatSiswaFasilitasModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        facilityCode: json["facility_code"],
        facilityName: json["facility_name"],
        totalFacility: json["total_facility"],
        status: json["status"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "facility_code": facilityCode,
        "facility_name": facilityName,
        "total_facility": totalFacility,
        "status": status,
        "date": date,
      };
}

class RiwayatSiswaFasilitasModel2 {
  RiwayatSiswaFasilitasModel2({
    required this.firstName,
    required this.lastName,
    required this.facilityCode,
    required this.facilityName,
    required this.totalFacility,
    required this.status,
    required this.nisn,
    required this.date,
  });

  String firstName;
  String lastName;
  String facilityCode;
  String facilityName;
  String totalFacility;
  String status;
  String nisn;
  String date;

  factory RiwayatSiswaFasilitasModel2.fromJson(Map<String, dynamic> json) =>
      RiwayatSiswaFasilitasModel2(
        firstName: json["first_name"],
        lastName: json["last_name"],
        facilityCode: json["facility_code"],
        facilityName: json["facility_name"],
        totalFacility: json["total_facility"],
        status: json["status"],
        nisn: json["nisn"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "facility_code": facilityCode,
        "facility_name": facilityName,
        "total_facility": totalFacility,
        "status": status,
        "nisn": nisn,
        "date": date,
      };
}

class RiwayatUserFasilitasModel {
  RiwayatUserFasilitasModel({
    required this.facilityCode,
    required this.facilityName,
    required this.totalFacility,
    required this.status,
    required this.date,
  });

  String facilityCode;
  String facilityName;
  String totalFacility;
  String status;
  String date;

  factory RiwayatUserFasilitasModel.fromJson(Map<String, dynamic> json) =>
      RiwayatUserFasilitasModel(
        facilityCode: json["facility_code"],
        facilityName: json["facility_name"],
        totalFacility: json["total_facility"],
        status: json["status"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "facility_code": facilityCode,
        "facility_name": facilityName,
        "total_facility": totalFacility,
        "status": status,
        "date": date,
      };
}

class DispenFasilitasModel {
  DispenFasilitasModel({
    required this.facilityId,
    required this.facilityCode,
    required this.facilityName,
    required this.numberOfFacility,
    required this.year,
    required this.ownedBy,
    required this.status,
    required this.date,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  int facilityId;
  String facilityCode;
  String facilityName;
  String numberOfFacility;
  String year;
  String ownedBy;
  String status;
  DateTime date;
  dynamic image;
  DateTime createdAt;
  DateTime updatedAt;

  factory DispenFasilitasModel.fromJson(Map<String, dynamic> json) =>
      DispenFasilitasModel(
        facilityId: json["facility_id"],
        facilityCode: json["facility_code"],
        facilityName: json["facility_name"],
        numberOfFacility: json["number_of_facility"],
        year: json["year"],
        ownedBy: json["owned_by"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "facility_id": facilityId,
        "facility_code": facilityCode,
        "facility_name": facilityName,
        "number_of_facility": numberOfFacility,
        "year": year,
        "owned_by": ownedBy,
        "status": status,
        "date": date.toIso8601String(),
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class MappingFasilitasDispenModel {
  MappingFasilitasDispenModel({
    required this.books,
  });

  List<Book> books;

  factory MappingFasilitasDispenModel.fromJson(Map<String, dynamic> json) =>
      MappingFasilitasDispenModel(
        books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
      };
}

class Book {
  Book({
    required this.facilityId,
    required this.status,
  });

  int facilityId;
  String status;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        facilityId: json["facility_id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "facility_id": facilityId,
        "status": status,
      };
}

class PengembalianFasilitasSiswaModel {
  PengembalianFasilitasSiswaModel({
    required this.loanFacilityId,
    required this.facilityId,
    required this.totalFacility,
    required this.fromDate,
    required this.toDate,
    required this.date,
    required this.status,
    required this.studentId,
    required this.createdAt,
    required this.updatedAt,
    required this.facilityCode,
    required this.facilityName,
    required this.numberOfFacility,
    required this.year,
    required this.image,
  });

  int loanFacilityId;
  int facilityId;
  String totalFacility;
  DateTime fromDate;
  DateTime toDate;
  DateTime date;
  String status;
  int studentId;
  DateTime createdAt;
  DateTime updatedAt;
  String facilityCode;
  String facilityName;
  String numberOfFacility;
  String year;
  String image;

  factory PengembalianFasilitasSiswaModel.fromJson(Map<String, dynamic> json) =>
      PengembalianFasilitasSiswaModel(
        loanFacilityId: json["loan_facility_id"],
        facilityId: json["facility_id"],
        totalFacility: json["total_facility"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
        date: DateTime.parse(json["date"]),
        status: json["status"],
        studentId: json["student_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        facilityCode: json["facility_code"],
        facilityName: json["facility_name"],
        numberOfFacility: json["number_of_facility"],
        year: json["year"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "loan_facility_id": loanFacilityId,
        "facility_id": facilityId,
        "total_facility": totalFacility,
        "from_date": fromDate.toIso8601String(),
        "to_date": toDate.toIso8601String(),
        "date": date.toIso8601String(),
        "status": status,
        "student_id": studentId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "facility_code": facilityCode,
        "facility_name": facilityName,
        "number_of_facility": numberOfFacility,
        "year": year,
        "image": image,
      };
}

class PengembalianFasilitasPegawaiModel {
  PengembalianFasilitasPegawaiModel({
    required this.loanFacilityId,
    required this.facilityId,
    required this.totalFacility,
    required this.fromDate,
    required this.toDate,
    required this.date,
    required this.status,
    required this.employeeId,
    required this.createdAt,
    required this.updatedAt,
    required this.facilityCode,
    required this.facilityName,
    required this.numberOfFacility,
    required this.year,
    required this.ownedBy,
    required this.image,
  });

  int loanFacilityId;
  int facilityId;
  String totalFacility;
  DateTime fromDate;
  DateTime toDate;
  DateTime date;
  String status;
  int employeeId;
  DateTime createdAt;
  DateTime updatedAt;
  String facilityCode;
  String facilityName;
  String numberOfFacility;
  String year;
  String ownedBy;
  String image;

  factory PengembalianFasilitasPegawaiModel.fromJson(
          Map<String, dynamic> json) =>
      PengembalianFasilitasPegawaiModel(
        loanFacilityId: json["loan_facility_id"],
        facilityId: json["facility_id"],
        totalFacility: json["total_facility"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
        date: DateTime.parse(json["date"]),
        status: json["status"],
        employeeId: json["employee_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        facilityCode: json["facility_code"],
        facilityName: json["facility_name"],
        numberOfFacility: json["number_of_facility"],
        year: json["year"],
        ownedBy: json["owned_by"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "loan_facility_id": loanFacilityId,
        "facility_id": facilityId,
        "total_facility": totalFacility,
        "from_date": fromDate.toIso8601String(),
        "to_date": toDate.toIso8601String(),
        "date": date.toIso8601String(),
        "status": status,
        "employee_id": employeeId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "facility_code": facilityCode,
        "facility_name": facilityName,
        "number_of_facility": numberOfFacility,
        "year": year,
        "owned_by": ownedBy,
        "image": image,
      };
}

class AprroveSiswaPengembalianFasilitas {
  AprroveSiswaPengembalianFasilitas({
    required this.loanFacilityId,
    required this.facilityId,
    required this.totalFacility,
    required this.fromDate,
    required this.toDate,
    required this.date,
    required this.status,
    required this.studentId,
    required this.createdAt,
    required this.updatedAt,
    required this.facilityCode,
    required this.facilityName,
    required this.numberOfFacility,
    required this.year,
    required this.image,
  });

  int loanFacilityId;
  int facilityId;
  String totalFacility;
  DateTime fromDate;
  DateTime toDate;
  DateTime date;
  String status;
  int studentId;
  DateTime createdAt;
  DateTime updatedAt;
  String facilityCode;
  String facilityName;
  String numberOfFacility;
  String year;
  String image;

  factory AprroveSiswaPengembalianFasilitas.fromJson(
          Map<String, dynamic> json) =>
      AprroveSiswaPengembalianFasilitas(
        loanFacilityId: json["loan_facility_id"],
        facilityId: json["facility_id"],
        totalFacility: json["total_facility"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
        date: DateTime.parse(json["date"]),
        status: json["status"],
        studentId: json["student_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        facilityCode: json["facility_code"],
        facilityName: json["facility_name"],
        numberOfFacility: json["number_of_facility"],
        year: json["year"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "loan_facility_id": loanFacilityId,
        "facility_id": facilityId,
        "total_facility": totalFacility,
        "from_date": fromDate.toIso8601String(),
        "to_date": toDate.toIso8601String(),
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "status": status,
        "student_id": studentId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "facility_code": facilityCode,
        "facility_name": facilityName,
        "number_of_facility": numberOfFacility,
        "year": year,
        "image": image,
      };
}
