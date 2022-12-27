class RiwayatMutasiSiswaModel {
  RiwayatMutasiSiswaModel({
    required this.mutasiId,
    required this.studentId,
    required this.toSchool,
    required this.letterSchoolTransfer,
    required this.rapor,
    required this.letterIjazah,
    required this.letterNoSanksi,
    required this.letterRecomDiknas,
    required this.kartuKeluarga,
    required this.suratKeteranganPindahSekolah,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.nisn,
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.fatherName,
    required this.motherName,
    required this.gender,
    required this.phone,
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
    required this.tanggal,
  });

  int mutasiId;
  int studentId;
  String toSchool;
  String letterSchoolTransfer;
  String rapor;
  String letterIjazah;
  String letterNoSanksi;
  String letterRecomDiknas;
  String kartuKeluarga;
  String suratKeteranganPindahSekolah;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String firstName;
  String lastName;
  String nisn;
  String placeOfBirth;
  DateTime dateOfBirth;
  String fatherName;
  String motherName;
  String gender;
  String phone;
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
  String tanggal;

  factory RiwayatMutasiSiswaModel.fromJson(Map<String, dynamic> json) =>
      RiwayatMutasiSiswaModel(
        mutasiId: json["mutasi_id"],
        studentId: json["student_id"],
        toSchool: json["to_school"],
        letterSchoolTransfer: json["letter_school_transfer"],
        rapor: json["rapor"],
        letterIjazah: json["letter_ijazah"],
        letterNoSanksi: json["letter_no_sanksi"],
        letterRecomDiknas: json["letter_recom_diknas"],
        kartuKeluarga: json["kartu_keluarga"],
        suratKeteranganPindahSekolah: json["surat_keterangan_pindah_sekolah"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        nisn: json["nisn"],
        placeOfBirth: json["place_of_birth"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        fatherName: json["father_name"],
        motherName: json["mother_name"],
        gender: json["gender"],
        phone: json["phone"],
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
        tanggal: json["tanggal"],
      );

  Map<String, dynamic> toJson() => {
        "mutasi_id": mutasiId,
        "student_id": studentId,
        "to_school": toSchool,
        "letter_school_transfer": letterSchoolTransfer,
        "rapor": rapor,
        "letter_ijazah": letterIjazah,
        "letter_no_sanksi": letterNoSanksi,
        "letter_recom_diknas": letterRecomDiknas,
        "kartu_keluarga": kartuKeluarga,
        "surat_keterangan_pindah_sekolah": suratKeteranganPindahSekolah,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "first_name": firstName,
        "last_name": lastName,
        "nisn": nisn,
        "place_of_birth": placeOfBirth,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "father_name": fatherName,
        "mother_name": motherName,
        "gender": gender,
        "phone": phone,
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
        "tanggal": tanggal,
      };
}

class RiwayatMutasiforKepsekModel {
  RiwayatMutasiforKepsekModel({
    required this.mutasiId,
    required this.studentId,
    required this.toSchool,
    required this.letterSchoolTransfer,
    required this.rapor,
    required this.letterIjazah,
    required this.letterNoSanksi,
    required this.letterRecomDiknas,
    required this.kartuKeluarga,
    required this.suratKeteranganPindahSekolah,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.nisn,
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.fatherName,
    required this.motherName,
    required this.gender,
    required this.phone,
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
  });

  int mutasiId;
  int studentId;
  String toSchool;
  String letterSchoolTransfer;
  String rapor;
  String letterIjazah;
  String letterNoSanksi;
  String letterRecomDiknas;
  String kartuKeluarga;
  String suratKeteranganPindahSekolah;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
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
  dynamic image;

  factory RiwayatMutasiforKepsekModel.fromJson(Map<String, dynamic> json) =>
      RiwayatMutasiforKepsekModel(
        mutasiId: json["mutasi_id"],
        studentId: json["student_id"],
        toSchool: json["to_school"],
        letterSchoolTransfer: json["letter_school_transfer"],
        rapor: json["rapor"],
        letterIjazah: json["letter_ijazah"],
        letterNoSanksi: json["letter_no_sanksi"],
        letterRecomDiknas: json["letter_recom_diknas"],
        kartuKeluarga: json["kartu_keluarga"],
        suratKeteranganPindahSekolah: json["surat_keterangan_pindah_sekolah"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        nisn: json["nisn"],
        placeOfBirth: json["place_of_birth"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        fatherName: json["father_name"],
        motherName: json["mother_name"],
        gender: json["gender"],
        phone: json["phone"],
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
      );

  Map<String, dynamic> toJson() => {
        "mutasi_id": mutasiId,
        "student_id": studentId,
        "to_school": toSchool,
        "letter_school_transfer": letterSchoolTransfer,
        "rapor": rapor,
        "letter_ijazah": letterIjazah,
        "letter_no_sanksi": letterNoSanksi,
        "letter_recom_diknas": letterRecomDiknas,
        "kartu_keluarga": kartuKeluarga,
        "surat_keterangan_pindah_sekolah": suratKeteranganPindahSekolah,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "first_name": firstName,
        "last_name": lastName,
        "nisn": nisn,
        "place_of_birth": placeOfBirth,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "father_name": fatherName,
        "mother_name": motherName,
        "gender": gender,
        "phone": phone,
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
      };
}


class RiwayatMutasiforKepsekModel2 {
  RiwayatMutasiforKepsekModel2({
    required this.mutasiId,
    required this.studentId,
    required this.toSchool,
    required this.letterSchoolTransfer,
    required this.rapor,
    required this.letterIjazah,
    required this.letterNoSanksi,
    required this.letterRecomDiknas,
    required this.kartuKeluarga,
    required this.suratKeteranganPindahSekolah,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.nisn,
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.fatherName,
    required this.motherName,
    required this.gender,
    required this.phone,
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
  });

  int mutasiId;
  int studentId;
  String toSchool;
  String letterSchoolTransfer;
  String rapor;
  String letterIjazah;
  String letterNoSanksi;
  String letterRecomDiknas;
  String kartuKeluarga;
  String suratKeteranganPindahSekolah;
  String status;
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
  dynamic image;

  factory RiwayatMutasiforKepsekModel2.fromJson(Map<String, dynamic> json) =>
      RiwayatMutasiforKepsekModel2(
        mutasiId: json["mutasi_id"],
        studentId: json["student_id"],
        toSchool: json["to_school"],
        letterSchoolTransfer: json["letter_school_transfer"],
        rapor: json["rapor"],
        letterIjazah: json["letter_ijazah"],
        letterNoSanksi: json["letter_no_sanksi"],
        letterRecomDiknas: json["letter_recom_diknas"],
        kartuKeluarga: json["kartu_keluarga"],
        suratKeteranganPindahSekolah: json["surat_keterangan_pindah_sekolah"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        nisn: json["nisn"],
        placeOfBirth: json["place_of_birth"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        fatherName: json["father_name"],
        motherName: json["mother_name"],
        gender: json["gender"],
        phone: json["phone"],
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
      );

  Map<String, dynamic> toJson() => {
        "mutasi_id": mutasiId,
        "student_id": studentId,
        "to_school": toSchool,
        "letter_school_transfer": letterSchoolTransfer,
        "rapor": rapor,
        "letter_ijazah": letterIjazah,
        "letter_no_sanksi": letterNoSanksi,
        "letter_recom_diknas": letterRecomDiknas,
        "kartu_keluarga": kartuKeluarga,
        "surat_keterangan_pindah_sekolah": suratKeteranganPindahSekolah,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "nisn": nisn,
        "place_of_birth": placeOfBirth,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "father_name": fatherName,
        "mother_name": motherName,
        "gender": gender,
        "phone": phone,
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
      };
}
