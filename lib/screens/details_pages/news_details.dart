import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:jankoyer/const/colors.dart';
import 'package:jankoyer/model/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/news_id_model.dart';
import 'package:flutter_share/flutter_share.dart';

class NewsDetails extends StatefulWidget {
  const NewsDetails(this.neww, {super.key});

  final NewsModelNewsNews neww;

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  Future<NewsIdModel> fetchAlbum() async {
    final response = await http.get(
        Uri.parse('http://jankoyer.com.tm/api/1.0/news/${widget.neww.id}'));
    if (response.statusCode == 200) {
      return NewsIdModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<NewsIdModel> futureAlbum;

  Future<void> postView() async {
    var url = Uri.parse(
        'https://jankoyer.com.tm/api/1.0/news/views/${widget.neww.id}');
    var headers = {'Content-Type': 'application/json'};
    var body = '';
    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('View sent successfully');
      }
    } else {
      if (kDebugMode) {
        print('Failed to send View. Error: ${response.statusCode}');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
    postView();
    fetchAdvertice();
  }

  String advertiseImage = '';
  String advertiseLink = '';
  fetchAdvertice() async {
    final response = await http.get(
        Uri.parse('https://jankoyer.com.tm/api/1.0/advertise?location=news'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      advertiseImage = jsonData[0]['image'];
      advertiseLink = jsonData[0]['link'];
      setState(() {});
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> _advertiseLink(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
        body: Center(
            child: FutureBuilder<NewsIdModel>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(children: [
                      Container(
                          alignment: Alignment.topLeft,
                          height: sizeHeight * 30,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(32, 247, 245, 245)
                                  .withOpacity(0.2),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "http://jankoyer.com.tm${widget.neww.smallImage}"),
                                  fit: BoxFit.fill)),
                          child: Padding(
                              padding: const EdgeInsets.only(top: 40, left: 20),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Icon(
                                      Icons.arrow_back_ios_new_outlined,
                                      color: Colors.white)))),
                      SizedBox(height: sizeHeight * 2.5),
                      SizedBox(
                          width: sizeWidth * 93,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text("${snapshot.data!.title}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500))),
                                Column(children: [
                                  const Icon(Icons.remove_red_eye_outlined,
                                      size: 12, color: AppColors.primary),
                                  Text("${snapshot.data!.views}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500))
                                ]),
                                SizedBox(width: sizeWidth * 4),
                                IconButton(
                                    onPressed: () async {
                                      await FlutterShare.share(
                                          title: '${snapshot.data!.title}',
                                          linkUrl: '${snapshot.data!.title}\n'
                                              'jankoyer.com.tm/news/${snapshot.data!.id}',
                                          chooserTitle:
                                              'Kim bilen paýlaşmakçy');
                                    },
                                    icon: const Icon(Icons.share_outlined,
                                        color: AppColors.primary, size: 30))
                              ])),
                      const Divider(
                          indent: 15,
                          endIndent: 15,
                          height: 40,
                          thickness: 1,
                          color: Colors.white),
                      Expanded(
                          child: SizedBox(
                              width: sizeWidth * 93,
                              child: ListView(
                                  padding: const EdgeInsets.all(0),
                                  children: [
                                    HtmlWidget("${snapshot.data!.text}",
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400)),
                                    // Html(
                                    //   data: "${snapshot.data!.text}",
                                    //   style: {
                                    //     "body": Style(
                                    //         color: Colors.white,
                                    //         fontSize: const FontSize(16.0),
                                    //         fontWeight: FontWeight.w400,
                                    //         textAlign: TextAlign.justify),
                                    //   },
                                    // ),
                                    SizedBox(height: sizeHeight * 2),
                                    InkWell(
                                        onTap: () {
                                          _advertiseLink(
                                              Uri.parse(advertiseLink));
                                        },
                                        child: Image.network(
                                            'https://jankoyer.com.tm$advertiseImage',
                                            fit: BoxFit.fill,
                                            height: 90)),
                                    SizedBox(height: sizeHeight * 2)
                                  ])))
                    ]);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return Column(children: [
                    Shimmer.fromColors(
                        baseColor: Colors.grey[800]!,
                        highlightColor: Colors.grey[500]!,
                        child: Container(
                            height: sizeHeight * 30,
                            decoration: const BoxDecoration(
                                color: AppColors.tabPossive))),
                    SizedBox(height: sizeHeight * 2.5),
                    Shimmer.fromColors(
                        baseColor: Colors.grey[800]!,
                        highlightColor: Colors.grey[500]!,
                        child: Container(
                            height: sizeHeight * 2.5,
                            width: sizeWidth * 93,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: AppColors.tabPossive))),
                    SizedBox(height: sizeHeight * 0.5),
                    Shimmer.fromColors(
                        baseColor: Colors.grey[800]!,
                        highlightColor: Colors.grey[500]!,
                        child: Container(
                            width: sizeWidth * 93,
                            height: sizeHeight * 2.5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: AppColors.tabPossive)))
                  ]);
                })));
  }
}
