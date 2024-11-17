
class InterviewsModelConversation {


  int? id;
  String? title;
  String? description;
  String? time;
  bool? active;
  String? image;
  String? video;
  String? videoDuration;

  InterviewsModelConversation({
    this.id,
    this.title,
    this.description,
    this.time,
    this.active,
    this.image,
    this.video,
    this.videoDuration,
  });
  InterviewsModelConversation.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    description = json['description']?.toString();
    time = json['time']?.toString();
    active = json['active'];
    image = json['image']?.toString();
    video = json['video']?.toString();
    videoDuration = json['videoDuration']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['time'] = time;
    data['active'] = active;
    data['image'] = image;
    data['video'] = video;
    data['videoDuration'] = videoDuration;
    return data;
  }
}

class InterviewsModel { 
  List<InterviewsModelConversation?>? conversation;
  String? size;
  String? page;
  int? totalPages;

  InterviewsModel({
    this.conversation,
    this.size,
    this.page,
    this.totalPages,
  });
  InterviewsModel.fromJson(Map<String, dynamic> json) {
  if (json['conversation'] != null) {
  final v = json['conversation'];
  final arr0 = <InterviewsModelConversation>[];
  v.forEach((v) {
  arr0.add(InterviewsModelConversation.fromJson(v));
  });
    conversation = arr0;
    }
    size = json['size']?.toString();
    page = json['page']?.toString();
    totalPages = json['totalPages']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (conversation != null) {
      final v = conversation;
      final arr0 = [];
  for (var v in v!) {
  arr0.add(v!.toJson());
  }
      data['conversation'] = arr0;
    }
    data['size'] = size;
    data['page'] = page;
    data['totalPages'] = totalPages;
    return data;
  }
}
