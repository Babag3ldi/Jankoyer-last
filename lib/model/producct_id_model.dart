import 'dart:convert';

class ProductModel {
    final int id;
    final String title;
    final String price;
    final bool active;
    final String description;
    final int shopCategoryId;
    final List<ShopAttachment> shopAttachments;

    ProductModel({
        required this.id,
        required this.title,
        required this.price,
        required this.active,
        required this.description,
        required this.shopCategoryId,
        required this.shopAttachments,
    });

    factory ProductModel.fromRawJson(String str) => ProductModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        active: json["active"],
        description: json["description"] ?? '',
        shopCategoryId: json["shopCategoryId"],
        shopAttachments: List<ShopAttachment>.from(json["shopAttachments"].map((x) => ShopAttachment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "active": active,
        "description": description,
        "shopCategoryId": shopCategoryId,
        "shopAttachments": List<dynamic>.from(shopAttachments.map((x) => x.toJson())),
    };
}

class ShopAttachment {
    final String image;
    final int shopCategoryItemId;

    ShopAttachment({
        required this.image,
        required this.shopCategoryItemId,
    });

    factory ShopAttachment.fromRawJson(String str) => ShopAttachment.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ShopAttachment.fromJson(Map<String, dynamic> json) => ShopAttachment(
        image: json["image"],
        shopCategoryItemId: json["shopCategoryItemId"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "shopCategoryItemId": shopCategoryItemId,
    };
}
