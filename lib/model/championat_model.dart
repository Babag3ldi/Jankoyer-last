class ChampionatModel {
/*
{
  "id": 2,
  "title": "Türkmenistanyň Futbol federasiýasynyň kubogy",
  "image": "/uploads/game/2023-06-05T07-42-22.575Z_TFF.png",
  "description": "TFF-nyň kubogy 2023",
  "scored": true
} 
*/

  int? id;
  String? title;
  String? image;
  String? description;
  bool? scored;

  ChampionatModel({
    this.id,
    this.title,
    this.image,
    this.description,
    this.scored,
  });
  ChampionatModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    image = json['image']?.toString();
    description = json['description']?.toString();
    scored = json['scored'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['description'] = description;
    data['scored'] = scored;
    return data;
  }
}
