class AdvertiseModel {
  int? id;
  String? image;
  String? link;
  bool? active;
  String? direction;
  String? createdAt;
  String? updatedAt;

  AdvertiseModel({
    this.id,
    this.image,
    this.link,
    this.active,
    this.direction,
    this.createdAt,
    this.updatedAt,
  });
  AdvertiseModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    image = json['image']?.toString();
    link = json['link']?.toString();
    active = json['active'];
    direction = json['direction']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['link'] = link;
    data['active'] = active;
    data['direction'] = direction;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
