class RiwayatIsiSaldoKoperasiModel {
  RiwayatIsiSaldoKoperasiModel({
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

  factory RiwayatIsiSaldoKoperasiModel.fromJson(Map<String, dynamic> json) =>
      RiwayatIsiSaldoKoperasiModel(
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
