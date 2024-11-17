///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class NewsModelNewsNews {
/*
{
  "id": 49,
  "active": true,
  "title": "Baş tälimçi ýok, ýöne baş futbolçy bar",
  "image": "/uploads/news/2023-06-14T11-21-15.063Z_eldor shomurodov.webp",
  "smallImage": "/uploads/news/small_2023-06-14T11-21-15.063Z_eldor shomurodov.webp",
  "views": 224,
  "description": "Baş tälimçi ýok, ýöne baş futbolçy bar",
  "time": "13/06/2023"
} 
*/

  int? id;
  bool? active;
  String? title;
  String? image;
  String? smallImage;
  int? views;
  String? description;
  String? time;

  NewsModelNewsNews({
    this.id,
    this.active,
    this.title,
    this.image,
    this.smallImage,
    this.views,
    this.description,
    this.time,
  });
  NewsModelNewsNews.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    active = json['active'];
    title = json['title']?.toString();
    image = json['image']?.toString();
    smallImage = json['smallImage']?.toString();
    views = json['views']?.toInt();
    description = json['description']?.toString();
    time = json['time']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['active'] = active;
    data['title'] = title;
    data['image'] = image;
    data['smallImage'] = smallImage;
    data['views'] = views;
    data['description'] = description;
    data['time'] = time;
    return data;
  }
}

// class NewsModelNews {
// /*
// {
//   "news": [
//     {
//       "id": 49,
//       "active": true,
//       "title": "Baş tälimçi ýok, ýöne baş futbolçy bar",
//       "image": "/uploads/news/2023-06-14T11-21-15.063Z_eldor shomurodov.webp",
//       "smallImage": "/uploads/news/small_2023-06-14T11-21-15.063Z_eldor shomurodov.webp",
//       "views": 224,
//       "description": "Baş tälimçi ýok, ýöne baş futbolçy bar",
//       "time": "13/06/2023"
//     }
//   ],
//   "size": "3",
//   "page": "7",
//   "totalPages": 21
// } 
// */

//   List<NewsModelNewsNews?>? news;
//   String? size;
//   String? page;
//   int? totalPages;

//   NewsModelNews({
//     this.news,
//     this.size,
//     this.page,
//     this.totalPages,
//   });
//   NewsModelNews.fromJson(Map<String, dynamic> json) {
//   if (json['news'] != null) {
//   final v = json['news'];
//   final arr0 = <NewsModelNewsNews>[];
//   v.forEach((v) {
//   arr0.add(NewsModelNewsNews.fromJson(v));
//   });
//     news = arr0;
//     }
//     size = json['size']?.toString();
//     page = json['page']?.toString();
//     totalPages = json['totalPages']?.toInt();
//   }
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     if (news != null) {
//       final v = news;
//       final arr0 = [];
//   v!.forEach((v) {
//   arr0.add(v!.toJson());
//   });
//       data['news'] = arr0;
//     }
//     data['size'] = size;
//     data['page'] = page;
//     data['totalPages'] = totalPages;
//     return data;
//   }
// }