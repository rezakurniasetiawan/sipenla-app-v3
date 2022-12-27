// class PengembalianOngoingPenggunaPerpusModel {
//   PengembalianOngoingPenggunaPerpusModel({
//     required this.loanBookId,
//     required this.bookId,
//     required this.totalBook,
//     required this.fromDate,
//     required this.toDate,
//     required this.date,
//     required this.status,
//     required this.bookcreator,
//     required this.bookyear,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.bookCode,
//     required this.bookName,
//     required this.numberOfBook,
//     required this.image,
//   });

//   int loanBookId;
//   int bookId;
//   String totalBook;
//   DateTime fromDate;
//   DateTime toDate;
//   DateTime date;
//   String status;
//   String bookcreator;
//   String bookyear;
//   DateTime createdAt;
//   DateTime updatedAt;
//   String bookCode;
//   String bookName;
//   String numberOfBook;
//   String image;

//   factory PengembalianOngoingPenggunaPerpusModel.fromJson(
//           Map<String, dynamic> json) =>
//       PengembalianOngoingPenggunaPerpusModel(
//         loanBookId: json["loan_book_id"],
//         bookId: json["book_id"],
//         totalBook: json["total_book"],
//         fromDate: DateTime.parse(json["from_date"]),
//         toDate: DateTime.parse(json["to_date"]),
//         date: DateTime.parse(json["date"]),
//         status: json["status"],
//         bookcreator: json["book_creator"],
//         bookyear: json["book_year"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         bookCode: json["book_code"],
//         bookName: json["book_name"],
//         numberOfBook: json["number_of_book"],
//         image: json["image"],
//       );

//   Map<String, dynamic> toJson() => {
//         "loan_book_id": loanBookId,
//         "book_id": bookId,
//         "total_book": totalBook,
//         "from_date": fromDate.toIso8601String(),
//         "to_date": toDate.toIso8601String(),
//         "date":
//             "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
//         "status": status,
//         "book_creator": bookcreator,
//         "book_year": bookyear,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "book_code": bookCode,
//         "book_name": bookName,
//         "number_of_book": numberOfBook,
//         "image": image,
//       };
// }

class PengembalianOngoingPenggunaPerpusModel {
  PengembalianOngoingPenggunaPerpusModel({
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

  factory PengembalianOngoingPenggunaPerpusModel.fromJson(
          Map<String, dynamic> json) =>
      PengembalianOngoingPenggunaPerpusModel(
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

class RiwayarPengPemModel {
  RiwayarPengPemModel({
    required this.bookCode,
    required this.bookName,
    required this.bookCreator,
    required this.bookYear,
    required this.totalBook,
    required this.status,
    required this.date,
  });

  String bookCode;
  String bookName;
  String bookCreator;
  String bookYear;
  String totalBook;
  String status;
  String date;

  factory RiwayarPengPemModel.fromJson(Map<String, dynamic> json) =>
      RiwayarPengPemModel(
        bookCode: json["book_code"],
        bookName: json["book_name"],
        bookCreator: json["book_creator"],
        bookYear: json["book_year"],
        totalBook: json["total_book"],
        status: json["status"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "book_code": bookCode,
        "book_name": bookName,
        "book_creator": bookCreator,
        "book_year": bookYear,
        "total_book": totalBook,
        "status": status,
        "date": date,
      };
}

class RiwayarPengPemModel2 {
  RiwayarPengPemModel2({
    required this.bookCode,
    required this.bookName,
    required this.bookCreator,
    required this.bookYear,
    // required this.totalBook,
    required this.status,
    required this.date,
  });

  String bookCode;
  String bookName;
  String bookCreator;
  String bookYear;
  // String totalBook;
  String status;
  String date;

  factory RiwayarPengPemModel2.fromJson(Map<String, dynamic> json) =>
      RiwayarPengPemModel2(
        bookCode: json["book_code"],
        bookName: json["book_name"],
        bookCreator: json["book_creator"],
        bookYear: json["book_year"],
        // totalBook: json["total_book"],
        status: json["status"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "book_code": bookCode,
        "book_name": bookName,
        "book_creator": bookCreator,
        "book_year": bookYear,
        // "total_book": totalBook,
        "status": status,
        "date": date,
      };
}

class HistorySumbangBukuSiswaModel {
  HistorySumbangBukuSiswaModel({
    required this.bookId,
    required this.firstName,
    required this.lastName,
    required this.bookCode,
    required this.bookName,
    required this.bookCreator,
    required this.bookYear,
    required this.status,
    required this.image,
    required this.nisn,
    required this.date,
  });

  int bookId;
  String firstName;
  String lastName;
  String bookCode;
  String bookName;
  String bookCreator;
  String bookYear;
  String status;
  String image;
  String nisn;
  String date;

  factory HistorySumbangBukuSiswaModel.fromJson(Map<String, dynamic> json) =>
      HistorySumbangBukuSiswaModel(
        bookId: json["book_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        bookCode: json["book_code"],
        bookName: json["book_name"],
        bookCreator: json["book_creator"],
        bookYear: json["book_year"],
        status: json["status"],
        image: json["image"],
        nisn: json["nisn"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "first_name": firstName,
        "last_name": lastName,
        "book_code": bookCode,
        "book_name": bookName,
        "book_creator": bookCreator,
        "book_year": bookYear,
        "status": status,
        "image": image,
        "nisn": nisn,
        "date": date,
      };
}

class HistorySumbangBukuPegawaiModel {
  HistorySumbangBukuPegawaiModel({
    required this.bookId,
    required this.firstName,
    required this.lastName,
    required this.bookCode,
    required this.bookName,
    required this.bookCreator,
    required this.bookYear,
    required this.status,
    required this.image,
    required this.nuptk,
    required this.date,
  });

  int bookId;
  String firstName;
  String lastName;
  String bookCode;
  String bookName;
  String bookCreator;
  String bookYear;
  String status;
  String image;
  String nuptk;
  String date;

  factory HistorySumbangBukuPegawaiModel.fromJson(Map<String, dynamic> json) =>
      HistorySumbangBukuPegawaiModel(
        bookId: json["book_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        bookCode: json["book_code"],
        bookName: json["book_name"],
        bookCreator: json["book_creator"],
        bookYear: json["book_year"],
        status: json["status"],
        image: json["image"],
        nuptk: json["nuptk"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "first_name": firstName,
        "last_name": lastName,
        "book_code": bookCode,
        "book_name": bookName,
        "book_creator": bookCreator,
        "book_year": bookYear,
        "status": status,
        "image": image,
        "nuptk": nuptk,
        "date": date,
      };
}

class PemabayaranDendaModel {
  PemabayaranDendaModel({
    required this.fineTransaction,
    required this.fineTransactionCode,
    required this.status,
    required this.waktu,
  });

  String fineTransaction;
  String fineTransactionCode;
  String status;
  String waktu;

  factory PemabayaranDendaModel.fromJson(Map<String, dynamic> json) =>
      PemabayaranDendaModel(
        fineTransaction: json["fine_transaction"],
        fineTransactionCode: json["fine_transaction_code"],
        status: json["status"],
        waktu: json["waktu"],
      );

  Map<String, dynamic> toJson() => {
        "fine_transaction": fineTransaction,
        "fine_transaction_code": fineTransactionCode,
        "status": status,
        "waktu": waktu,
      };
}
