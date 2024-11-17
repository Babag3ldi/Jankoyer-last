// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

class VideoReportCategoryModel {
    final int id;
    final String title;
    final String image;
    final DateTime createdAt;
    final DateTime updatedAt;

    VideoReportCategoryModel({
        required this.id,
        required this.title,
        required this.image,
        required this.createdAt,
        required this.updatedAt,
    });

    factory VideoReportCategoryModel.fromRawJson(String str) => VideoReportCategoryModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory VideoReportCategoryModel.fromJson(Map<String, dynamic> json) => VideoReportCategoryModel(
        id: json["id"] == null ? null : json["id"] ,
        title: json["title"] == null ? null : json["title"] ,
        image: json["image"] == null ? null : json["image"] ,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );
  
    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
