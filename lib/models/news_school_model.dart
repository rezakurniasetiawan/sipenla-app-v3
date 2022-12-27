class NewsModel {
  int newsId;
  String newsTitle;
  String newsContent;
  dynamic newsImage;
  DateTime createdAt;
  DateTime updatedAt;
  String date;

  NewsModel({
    required this.newsId,
    required this.newsTitle,
    required this.newsContent,
    required this.newsImage,
    required this.createdAt,
    required this.updatedAt,
    required this.date,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      newsId: json["news_id"],
      newsTitle: json["news_title"],
      newsContent: json["news_content"],
      newsImage: json["news_image"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      date: json["date"],
    );
  }
}
