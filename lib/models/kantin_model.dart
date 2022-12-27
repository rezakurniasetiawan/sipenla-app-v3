class ListMerchantModel {
  ListMerchantModel({
    required this.id,
    required this.namaKantin,
    required this.kodeKantin,
    required this.firstName,
    required this.lastName,
  });

  int id;
  String namaKantin;
  String kodeKantin;
  String firstName;
  String lastName;

  factory ListMerchantModel.fromJson(Map<String, dynamic> json) =>
      ListMerchantModel(
        id: json["id"],
        namaKantin: json["nama_kantin"],
        kodeKantin: json["kode_kantin"],
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_kantin": namaKantin,
        "kode_kantin": kodeKantin,
        "first_name": firstName,
        "last_name": lastName,
      };
}

class RiwayatBayarKantinModel {
  RiwayatBayarKantinModel({
    required this.id,
    required this.userId,
    required this.price,
    required this.codeTransaction,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  int price;
  String codeTransaction;
  DateTime date;
  DateTime createdAt;
  DateTime updatedAt;

  factory RiwayatBayarKantinModel.fromJson(Map<String, dynamic> json) =>
      RiwayatBayarKantinModel(
        id: json["id"],
        userId: json["user_id"],
        price: json["price"],
        codeTransaction: json["code_transaction"],
        date: DateTime.parse(json["date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "price": price,
        "code_transaction": codeTransaction,
        "date": date.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
