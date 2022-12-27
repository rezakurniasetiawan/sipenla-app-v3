class TopupUserModel {
  TopupUserModel({
    required this.balance,
    required this.balanceCode,
    required this.expire,
  });

  String balance;
  String balanceCode;
  String expire;

  factory TopupUserModel.fromJson(Map<String, dynamic> json) => TopupUserModel(
        balance: json["balance"],
        balanceCode: json["balance_code"],
        expire: json["expire"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "balance_code": balanceCode,
        "expire": expire,
      };
}

class CheckCodeForAprroveModel {
  CheckCodeForAprroveModel({
    required this.firstName,
    required this.lastName,
    required this.balanceCode,
    required this.balance,
    required this.createdAt,
    required this.waktu,
  });

  String firstName;
  String lastName;
  String balanceCode;
  int balance;
  DateTime createdAt;
  String waktu;

  factory CheckCodeForAprroveModel.fromJson(Map<String, dynamic> json) =>
      CheckCodeForAprroveModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        balanceCode: json["balance_code"],
        balance: json["balance"],
        createdAt: DateTime.parse(json["created_at"]),
        waktu: json["waktu"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "balance_code": balanceCode,
        "balance": balance,
        "created_at": createdAt.toIso8601String(),
        "waktu": waktu,
      };
}

class HistoryIsiSaldoModel {
  HistoryIsiSaldoModel({
    required this.balanceCode,
    required this.balance,
    required this.createdAt,
    required this.status,
    required this.waktu,
  });

  String balanceCode;
  int balance;
  DateTime createdAt;
  String status;
  String waktu;

  factory HistoryIsiSaldoModel.fromJson(Map<String, dynamic> json) =>
      HistoryIsiSaldoModel(
        balanceCode: json["balance_code"],
        balance: json["balance"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
        waktu: json["waktu"],
      );

  Map<String, dynamic> toJson() => {
        "balance_code": balanceCode,
        "balance": balance,
        "created_at": createdAt.toIso8601String(),
        "status": status,
        "waktu": waktu,
      };
}

class HistoryApproveIsiSaldo {
  HistoryApproveIsiSaldo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.balance,
    required this.balanceCode,
    required this.waktu,
  });

  int id;
  String firstName;
  String lastName;
  DateTime createdAt;
  int balance;
  String balanceCode;
  String waktu;

  factory HistoryApproveIsiSaldo.fromJson(Map<String, dynamic> json) =>
      HistoryApproveIsiSaldo(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        createdAt: DateTime.parse(json["created_at"]),
        balance: json["balance"],
        balanceCode: json["balance_code"],
        waktu: json["waktu"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "created_at": createdAt.toIso8601String(),
        "balance": balance,
        "balance_code": balanceCode,
        "waktu": waktu,
      };
}

class ListAprroveTarikSaldoModel {
  ListAprroveTarikSaldoModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.payout,
    required this.payoutCode,
    required this.waktu,
  });

  int id;
  String firstName;
  String lastName;
  DateTime createdAt;
  int payout;
  String payoutCode;
  String waktu;

  factory ListAprroveTarikSaldoModel.fromJson(Map<String, dynamic> json) =>
      ListAprroveTarikSaldoModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        createdAt: DateTime.parse(json["created_at"]),
        payout: json["payout"],
        payoutCode: json["payout_code"],
        waktu: json["waktu"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "created_at": createdAt.toIso8601String(),
        "payout": payout,
        "payout_code": payoutCode,
        "waktu": waktu,
      };
}

class HistoryUserTarikSaldo {
  HistoryUserTarikSaldo({
    required this.payout,
    required this.createdAt,
    required this.status,
    required this.payoutCode,
    required this.waktu,
  });

  int payout;
  DateTime createdAt;
  String status;
  String payoutCode;
  String waktu;

  factory HistoryUserTarikSaldo.fromJson(Map<String, dynamic> json) =>
      HistoryUserTarikSaldo(
        payout: json["payout"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
        payoutCode: json["payout_code"],
        waktu: json["waktu"],
      );

  Map<String, dynamic> toJson() => {
        "payout": payout,
        "created_at": createdAt.toIso8601String(),
        "status": status,
        "payout_code": payoutCode,
        "waktu": waktu,
      };
}

class RiwayatDendaUser {
  RiwayatDendaUser({
    required this.fineTransactionCode,
    required this.fineTransaction,
    required this.createdAt,
    required this.status,
    required this.waktu,
  });

  String fineTransactionCode;
  int fineTransaction;
  DateTime createdAt;
  String status;
  String waktu;

  factory RiwayatDendaUser.fromJson(Map<String, dynamic> json) =>
      RiwayatDendaUser(
        fineTransactionCode: json["fine_transaction_code"],
        fineTransaction: json["fine_transaction"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
        waktu: json["waktu"],
      );

  Map<String, dynamic> toJson() => {
        "fine_transaction_code": fineTransactionCode,
        "fine_transaction": fineTransaction,
        "created_at": createdAt.toIso8601String(),
        "status": status,
        "waktu": waktu,
      };
}

class KonfirmasiTarikSaldoSiswaModel {
  KonfirmasiTarikSaldoSiswaModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.amount,
    required this.savingCode,
    required this.waktu,
  });

  int id;
  String firstName;
  String lastName;
  DateTime createdAt;
  int amount;
  String savingCode;
  String waktu;

  factory KonfirmasiTarikSaldoSiswaModel.fromJson(Map<String, dynamic> json) =>
      KonfirmasiTarikSaldoSiswaModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        createdAt: DateTime.parse(json["created_at"]),
        amount: json["amount"],
        savingCode: json["saving_code"],
        waktu: json["waktu"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "created_at": createdAt.toIso8601String(),
        "amount": amount,
        "saving_code": savingCode,
        "waktu": waktu,
      };
}

class RiwayatIsiTabunganModel {
  RiwayatIsiTabunganModel({
    required this.transactionId,
    required this.userId,
    required this.orderId,
    required this.itemName,
    required this.grossAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.waktu,
  });

  int transactionId;
  int userId;
  String orderId;
  String itemName;
  int grossAmount;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String waktu;

  factory RiwayatIsiTabunganModel.fromJson(Map<String, dynamic> json) =>
      RiwayatIsiTabunganModel(
        transactionId: json["transaction_id"],
        userId: json["user_id"],
        orderId: json["order_id"],
        itemName: json["item_name"],
        grossAmount: json["gross_amount"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        waktu: json["waktu"],
      );

  Map<String, dynamic> toJson() => {
        "transaction_id": transactionId,
        "user_id": userId,
        "order_id": orderId,
        "item_name": itemName,
        "gross_amount": grossAmount,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "waktu": waktu,
      };
}

class RiwayatTarikTabunganModel {
  RiwayatTarikTabunganModel({
    required this.amount,
    required this.savingCode,
    required this.createdAt,
    required this.status,
    required this.waktu,
  });

  int amount;
  String savingCode;
  DateTime createdAt;
  String status;
  String waktu;

  factory RiwayatTarikTabunganModel.fromJson(Map<String, dynamic> json) =>
      RiwayatTarikTabunganModel(
        amount: json["amount"],
        savingCode: json["saving_code"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
        waktu: json["waktu"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "saving_code": savingCode,
        "created_at": createdAt.toIso8601String(),
        "status": status,
        "waktu": waktu,
      };
}

class ManajemenTagihanModel {
  ManajemenTagihanModel({
    required this.id,
    required this.eventName,
    required this.totalPrice,
    required this.fromDate,
    required this.toDate,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String eventName;
  int totalPrice;
  DateTime fromDate;
  DateTime toDate;
  DateTime createdAt;
  DateTime updatedAt;

  factory ManajemenTagihanModel.fromJson(Map<String, dynamic> json) =>
      ManajemenTagihanModel(
        id: json["id"],
        eventName: json["event_name"],
        totalPrice: json["total_price"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_name": eventName,
        "total_price": totalPrice,
        "from_date":
            "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
        "to_date":
            "${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class ManajemenSppModel {
  ManajemenSppModel({
    required this.id,
    required this.mount,
    required this.totalPrice,
    required this.fromDate,
    required this.toDate,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String mount;
  int totalPrice;
  DateTime fromDate;
  DateTime toDate;
  DateTime createdAt;
  DateTime updatedAt;

  factory ManajemenSppModel.fromJson(Map<String, dynamic> json) =>
      ManajemenSppModel(
        id: json["id"],
        mount: json["mount"],
        totalPrice: json["total_price"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mount": mount,
        "total_price": totalPrice,
        "from_date":
            "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
        "to_date":
            "${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class RiwayatTransaksibyUserModel {
  RiwayatTransaksibyUserModel({
    required this.transactionId,
    required this.userId,
    required this.orderId,
    required this.itemName,
    required this.grossAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int transactionId;
  int userId;
  String orderId;
  String itemName;
  int grossAmount;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory RiwayatTransaksibyUserModel.fromJson(Map<String, dynamic> json) =>
      RiwayatTransaksibyUserModel(
        transactionId: json["transaction_id"],
        userId: json["user_id"],
        orderId: json["order_id"],
        itemName: json["item_name"],
        grossAmount: json["gross_amount"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "transaction_id": transactionId,
        "user_id": userId,
        "order_id": orderId,
        "item_name": itemName,
        "gross_amount": grossAmount,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
