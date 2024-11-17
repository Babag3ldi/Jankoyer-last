
// class GalleryDetailsModel {
//     final int id;
//     final String title;
//     final DateTime createdAt;
//     final DateTime updatedAt;
//     final List<GalleryAttachment> galleryAttachments;

//     GalleryDetailsModel({
//         required this.id,
//         required this.title,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.galleryAttachments,
//     });

//     factory GalleryDetailsModel.fromRawJson(String str) => GalleryDetailsModel.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory GalleryDetailsModel.fromJson(Map<String, dynamic> json) => GalleryDetailsModel(
//         id: json["id"],
//         title: json["title"] == null ? null : json['title'],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         galleryAttachments: List<GalleryAttachment>.from(json["galleryAttachments"].map((x) => GalleryAttachment.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "galleryAttachments": List<dynamic>.from(galleryAttachments.map((x) => x.toJson())),
//     };
// }

class GalleryDetailsModel {
    final int id;
    final String image;
    // final DateTime createdAt;
    // final DateTime updatedAt;
    final int galleryId;

    GalleryDetailsModel({
        required this.id,
        required this.image,
        // required this.createdAt,
        // required this.updatedAt,
        required this.galleryId,
    });

   

    factory GalleryDetailsModel.fromJson(Map<String, dynamic> json) => GalleryDetailsModel(
        id: json["id"],
        image: json["image"],
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
        galleryId: json["galleryId"],
    );

    
}
