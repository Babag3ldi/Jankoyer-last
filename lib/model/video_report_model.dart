import 'dart:convert';

class VideoReportModel {
    final List<VideoReportModels> videoReport;
    final String size;
    final String page;
    final int totalPages;

    VideoReportModel({
        required this.videoReport,
        required this.size,
        required this.page,
        required this.totalPages,
    });

    factory VideoReportModel.fromRawJson(String str) => VideoReportModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory VideoReportModel.fromJson(Map<String, dynamic> json) => VideoReportModel(
        videoReport: List<VideoReportModels>.from(json["videoReport"].map((x) => VideoReportModels.fromJson(x))),
        size: json["size"],
        page: json["page"],
        totalPages: json["totalPages"],
    );

    Map<String, dynamic> toJson() => {
        "videoReport": List<dynamic>.from(videoReport.map((x) => x.toJson())),
        "size": size,
        "page": page,
        "totalPages": totalPages,
    };
}

class VideoReportModels {
    final int id;
    final String title;
    final dynamic description;
    final String image;
    final String video;
    final String videoDuration;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int videoReportCategoryId;

    VideoReportModels({
        required this.id,
        required this.title,
        required this.description,
        required this.image,
        required this.video,
        required this.videoDuration,
        required this.createdAt,
        required this.updatedAt,
        required this.videoReportCategoryId,
    });

    factory VideoReportModels.fromJson(Map<String, dynamic> json) => VideoReportModels(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        video: json["video"],
        videoDuration: json["videoDuration"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        videoReportCategoryId: json["videoReportCategoryId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "video": video,
        "videoDuration": videoDuration,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "videoReportCategoryId": videoReportCategoryId,
    };
}
