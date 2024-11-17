
class GalleryModel {
    final List<Gallery> gallery;
    final String size;
    final String page;
    final int totalPages;

    GalleryModel({
        required this.gallery,
        required this.size,
        required this.page,
        required this.totalPages,
    });

   

    factory GalleryModel.fromJson(Map<String, dynamic> json) => GalleryModel(
        gallery: List<Gallery>.from(json["gallery"].map((x) => Gallery.fromJson(x))),
        size: json["size"],
        page: json["page"],
        totalPages: json["totalPages"],
    );

  
}

class Gallery {
    final int id;
    final String title;
    final DateTime createdAt;
    final DateTime updatedAt;
    final List<GalleryAttachment> galleryAttachments;

    Gallery({
        required this.id,
        required this.title,
        required this.createdAt,
        required this.updatedAt,
        required this.galleryAttachments,
    });

  
    factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        id: json["id"],
        title: json["title"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        galleryAttachments: List<GalleryAttachment>.from(json["galleryAttachments"].map((x) => GalleryAttachment.fromJson(x))),
    );
}

class GalleryAttachment {
    final int id;
    final String image;
    // final DateTime createdAt;
    // final DateTime updatedAt;
    final int galleryId;

    GalleryAttachment({
        required this.id,
        required this.image,
        // required this.createdAt,
        // required this.updatedAt,
        required this.galleryId,
    });

  

    factory GalleryAttachment.fromJson(Map<String, dynamic> json) => GalleryAttachment(
        id: json["id"],
        image: json["image"],
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
        galleryId: json["galleryId"],
    );
}
