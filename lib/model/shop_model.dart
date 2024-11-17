import 'dart:convert';

class ShopModel {
    final int id;
    final String title;
    final String phoneNumber;
    final String image;

    ShopModel({
        required this.id,
        required this.title,
        required this.phoneNumber,
        required this.image,
    });

    factory ShopModel.fromRawJson(String str) => ShopModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        id: json["id"],
        title: json["title"],
        phoneNumber: json["phoneNumber"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "phoneNumber": phoneNumber,
        "image": image,
    };
}
