class RoomChatModel {
  RoomChatModel({
    required this.roomId,
    required this.userId,
    required this.adminId,
    required this.nameRoom,
    required this.imageProfile,
    required this.createdAt,
    required this.updatedAt,
  });

  int roomId;
  int userId;
  int adminId;
  String nameRoom;
  String imageProfile;
  DateTime createdAt;
  DateTime updatedAt;

  factory RoomChatModel.fromJson(Map<String, dynamic> json) => RoomChatModel(
        roomId: json["room_id"],
        userId: json["user_id"],
        adminId: json["admin_id"],
        nameRoom: json["name_room"],
        imageProfile: json["image_profile"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "room_id": roomId,
        "user_id": userId,
        "admin_id": adminId,
        "name_room": nameRoom,
        "image_profile": imageProfile,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class ListChatModel {
    ListChatModel({
      required  this.id,
      required  this.userId,
      required  this.roomId,
      required  this.message,
      required  this.readStamp,
     required   this.createdAt,
      required  this.updatedAt,
      required  this.isMe,
    });

    int id;
    int userId;
    int roomId;
    String message;
    dynamic readStamp;
    DateTime createdAt;
    DateTime updatedAt;
    bool isMe;

    factory ListChatModel.fromJson(Map<String, dynamic> json) => ListChatModel(
        id: json["id"],
        userId: json["user_id"],
        roomId: json["room_id"],
        message: json["message"],
        readStamp: json["read_stamp"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isMe: json["isMe"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "room_id": roomId,
        "message": message,
        "read_stamp": readStamp,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "isMe": isMe,
    };
}
