
class MainModel {
  final int size;
  final int page;
  final int totalPage;
  final List<MainModelMain> data;

  MainModel({
    required this.size,
    required this.page,
    required this.totalPage,
    required this.data,
  });

  factory MainModel.fromJson(Map<String, dynamic> json) => MainModel(
        size: json["size"],
        page: json["page"],
        totalPage: json["totalPage"],
        data: List<MainModelMain>.from(
            json["data"].map((x) => MainModelMain.fromJson(x))),
      );
}

class MainModelMain {
  final int? id;
  final String title;
  final String? description;
  final String? time;
  final String? image;
  final String? video;
  final String? videoDuration;
  final int? likes;
  final int? views;
  final String type;
  final List<String>? images;
  final int? videoReportCategoryId;
  final String? smallImage;
  final String? link;

  MainModelMain( {
    required this.id,
    required this.title,
    this.description,
    this.time,
    this.image,
    this.video,
    this.videoDuration,
    this.likes,
    required this.views,
    required this.type,
    this.images,
    this.videoReportCategoryId,
    this.smallImage,
    this.link,
  });

  factory MainModelMain.fromJson(Map<String, dynamic> json) => MainModelMain(
        id: json["id"],
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        time: json["time"] ?? '',
        image: json["image"] ?? "",
        video: json["video"] ?? '',
        videoDuration: json["videoDuration"] ?? '',
        likes: json["likes"] ?? 0,
        views: json["views"] ?? 0,
        type: json["type"] ?? "",
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        videoReportCategoryId: json["videoReportCategoryId"],
        smallImage: json["smallImage"] ?? '',
        link: json["link"]
      );
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
