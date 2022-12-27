class RiwayatMonitoringModel {
  RiwayatMonitoringModel({
    required this.date,
    required this.grade,
    required this.subject,
    required this.hadir,
    required this.alpha,
    required this.sakit,
    required this.izin,
  });

  String date;
  String grade;
  String subject;
  String hadir;
  String alpha;
  String sakit;
  String izin;

  factory RiwayatMonitoringModel.fromJson(Map<String, dynamic> json) =>
      RiwayatMonitoringModel(
        date: json["date"],
        grade: json["grade"],
        subject: json["subject"],
        hadir: json["hadir"],
        alpha: json["alpha"],
        sakit: json["sakit"],
        izin: json["izin"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "grade": grade,
        "subject": subject,
        "hadir": hadir,
        "alpha": alpha,
        "sakit": sakit,
        "izin": izin,
      };
}

class RiwayatMonitoringEkstraModel {
  RiwayatMonitoringEkstraModel({
    required this.date,
    required this.extracurricular,
    required this.hadir,
    required this.alpha,
    required this.sakit,
    required this.izin,
  });

  String date;
  String extracurricular;
  String hadir;
  String alpha;
  String sakit;
  String izin;

  factory RiwayatMonitoringEkstraModel.fromJson(Map<String, dynamic> json) =>
      RiwayatMonitoringEkstraModel(
        date: json["date"],
        extracurricular: json["extracurricular"],
        hadir: json["hadir"],
        alpha: json["alpha"],
        sakit: json["sakit"],
        izin: json["izin"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "extracurricular": extracurricular,
        "hadir": hadir,
        "alpha": alpha,
        "sakit": sakit,
        "izin": izin,
      };
}
