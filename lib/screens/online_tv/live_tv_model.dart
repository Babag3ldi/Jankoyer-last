// ignore_for_file: non_constant_identifier_names

class LiveTVModel {
  String title;
  String image;
  String video;

  LiveTVModel({
    required this.title,
    required this.image,
    required this.video,
  });
}

List<LiveTVModel> live_tv_list =[
  LiveTVModel(title: 'Türkmen Sport', image: 'assets/images/1.png', video: 'https://horjuntv.com.tm/chanel2/ch007.m3u8'),
  LiveTVModel(title: 'Football HD', image: 'assets/images/2.png', video: 'https://horjuntv.com.tm/chanel2/ch093.m3u8'),
  LiveTVModel(title: 'ФУТБОЛ 1', image: 'assets/images/3.png', video: 'https://horjuntv.com.tm/chanel2/ch052.m3u8'),
  LiveTVModel(title: 'Варзиш', image: 'assets/images/4.png', video: 'https://horjuntv.com.tm/chanel/ch040.m3u8'),
  LiveTVModel(title: 'IDMAN', image: 'assets/images/5.png', video: 'https://horjuntv.com.tm/chanel/ch062.m3u8'),
  LiveTVModel(title: 'Матч ТВ', image: 'assets/images/6.png', video: 'https://horjuntv.com.tm/chanel/ch013.m3u8'),
  LiveTVModel(title: 'Mono TV', image: 'assets/images/7.png', video: 'https://horjuntv.com.tm/chanel/ch0100.m3u8'),
];