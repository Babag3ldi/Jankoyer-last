
class NewsIdModel {
  int? id;
  String? image;
  String? title;
  String? description;
  String? text;
  int? views;
  String? time;

  NewsIdModel({
    this.id,
    this.image,
    this.title,
    this.description,
    this.text,
    this.views,
    this.time,
  });
  NewsIdModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    image = json['image']?.toString();
    title = json['title']?.toString();
    description = json['description']?.toString();
    text = json['text']?.toString();
    views = json['views']?.toInt();
    time = json['time']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['description'] = description;
    data['text'] = text;
    data['views'] = views;
    data['time'] = time;
    return data;
  }
}
