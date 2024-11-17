// ignore_for_file: unused_field, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jankoyer/const/colors.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../model/video_report_category_model.dart';
import 'package:http/http.dart' as http;

import '../../model/video_report_model.dart';
import 'video_report_detail.dart';


class VideoPage extends StatefulWidget {
  const VideoPage(this.videoCategoryInx, {super.key});
  final VideoReportCategoryModel videoCategoryInx;
  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late List<VideoReportModels> videoReport;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    videoReport = await getVideoReport();
    setState(() {
      isLoading = false;
    });
  }

  Future<List<VideoReportModels>> getVideoReport() async {
    final uri =
        Uri.parse("https://jankoyer.com.tm/api/1.0/videoReport?category=${widget.videoCategoryInx.id}");
    var response = await http.get(uri);
    var json = jsonDecode(response.body)['videoReport'] as List;
    if (response.statusCode == 200) {
      List<VideoReportModels> videoReport =
          List<VideoReportModels>.from(
              json.map((e) => VideoReportModels.fromJson(e)));
      return videoReport;
    } else {
      String videoReport = 'no internet';
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title:  Text(
            widget.videoCategoryInx.title,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          :  Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Center(
              child: SizedBox(
                width: sizeWidth * 91,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: videoReport.length,
                    itemBuilder: (context, index) {
                      // InterviewsModel getinterviewsModel = interviewsModel[index];
                      final videoReportInx = videoReport[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          height: sizeHeight * 21,
                          decoration: BoxDecoration(
                            color:
                                const Color.fromARGB(32, 247, 245, 245).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Stack(
                            children: [
                              InkWell(
                                onTap: (() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VideoReportDetail(videoReportInx)),
                                  );
                                }),
                                child: SizedBox(
                                    width: sizeWidth * 91,
                                    child: Image.network(
                                        "http://jankoyer.com.tm${videoReportInx.image}",
                                        color: const Color.fromARGB(255, 155, 154, 154)
                                            .withOpacity(0.9),
                                        colorBlendMode: BlendMode.modulate,
                                        fit: BoxFit.fill)),
                              ),
                              InkWell(
                                onTap: (() {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           VideoReportDetail(videoReportInx)),
                                  // );
                                  pushNewScreen(
                                        context,
                                        screen: VideoReportDetail(videoReportInx),
                                        withNavBar: false,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                }),
                                child: Center(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: sizeHeight * 4.5,
                                    width: sizeWidth * 11,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.0),
                                        border:
                                            Border.all(color: AppColors.primary)),
                                    child: const Icon(
                                      Icons.play_arrow_outlined,
                                      color: AppColors.primary,
                                      size: 35,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  width: sizeWidth * 91,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5)),
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth*73,
                                          child: Text(
                                            videoReportInx.title,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.history,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              videoReportInx.videoDuration,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              ),
          ));
  }
}
