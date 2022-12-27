class MappingServerBook {
  MappingServerBook({
    required this.books,
  });

  List<BookPeminjamanServer> books;

  factory MappingServerBook.fromJson(Map<String, dynamic> json) =>
      MappingServerBook(
        books: List<BookPeminjamanServer>.from(
            json["books"].map((x) => BookPeminjamanServer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
      };
}

class BookPeminjamanServer {
  BookPeminjamanServer({
    required this.bookId,
    required this.totalBook,
    required this.toDate,
  });

  int bookId;
  int totalBook;
  int toDate;

  factory BookPeminjamanServer.fromJson(Map<String, dynamic> json) =>
      BookPeminjamanServer(
        bookId: json["book_id"],
        totalBook: json["total_book"],
        toDate: json["to_date"],
      );

  Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "total_book": totalBook,
        "to_date": toDate,
      };
}

class MappingLocalBook {
  MappingLocalBook({
    required this.books,
  });

  List<BookPeminjamanLocal> books;

  factory MappingLocalBook.fromJson(Map<String, dynamic> json) =>
      MappingLocalBook(
        books: List<BookPeminjamanLocal>.from(
            json["books"].map((x) => BookPeminjamanLocal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
      };
}

class BookPeminjamanLocal {
  BookPeminjamanLocal({
    required this.bookId,
    required this.totalBook,
    required this.toDate,
    required this.nameBook,
    required this.codeBook,
    required this.imageBook,
  });

  int bookId;
  int totalBook;
  int toDate;
  String nameBook;
  String codeBook;
  String imageBook;

  factory BookPeminjamanLocal.fromJson(Map<String, dynamic> json) =>
      BookPeminjamanLocal(
        bookId: json["book_id"],
        totalBook: json["total_book"],
        toDate: json["to_date"],
        nameBook: json["name_book"],
        codeBook: json["code_book"],
        imageBook: json["image_book"],
      );

  Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "total_book": totalBook,
        "to_date": toDate,
        "name_book": nameBook,
        "code_book": codeBook,
        "image_book": imageBook,
      };
}
