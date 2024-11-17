// ignore_for_file: unused_local_variable, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jankoyer/screens/video_report/video_page.dart';

import '../../const/colors.dart';
import '../../model/video_report_category_model.dart';

class VideoReportCategoryPage extends StatefulWidget {
  const VideoReportCategoryPage({super.key});

  @override
  State<VideoReportCategoryPage> createState() =>
      _VideoReportCategoryPageState();
}

class _VideoReportCategoryPageState extends State<VideoReportCategoryPage> {
  late List<VideoReportCategoryModel> video_category;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    video_category = await getgallery();
    setState(() {
      isLoading = false;
    });
  }

  Future<List<VideoReportCategoryModel>> getgallery() async {
    final uri =
        Uri.parse("https://jankoyer.com.tm/api/1.0/videoReportCategory");
    var response = await http.get(uri);
    print("galleryGettt => ${response.statusCode}");
    var json = jsonDecode(response.body) as List;
    if (response.statusCode == 200) {
      List<VideoReportCategoryModel> gallery =
          List<VideoReportCategoryModel>.from(
              json.map((e) => VideoReportCategoryModel.fromJson(e)));
      return gallery;
    } else {
      String gallery = 'no internet';
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
        title: const Text(
          'Wideoreportaž',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Center(
                child: SizedBox(
                  width: sizeWidth * 91,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(top: 10),
                      itemCount: video_category.length,
                      itemBuilder: (context, index) {
                        final videoCategoryInx = video_category[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoPage(
                                          videoCategoryInx,
                                        )),
                              );
                            },
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              height: sizeHeight * 28,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                // color:  Colors.white
                                //     .withOpacity(0.9),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VideoPage(videoCategoryInx)),
                                      );
                                      
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          // color:  Colors.white
                                          //     .withOpacity(0.9),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                "https://jankoyer.com.tm${videoCategoryInx.image}",
                                              ),
                                              fit: BoxFit.fill)),
                                      width: sizeWidth * 91,
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
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: sizeWidth * 85,
                                              child: Text(
                                                videoCategoryInx.title,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            // Row(
                                            //   children: [
                                            //     const Icon(
                                            //       Icons.history,
                                            //       color: Colors.white,
                                            //     ),
                                            //     const SizedBox(
                                            //       width: 5,
                                            //     ),
                                            //     // Text(
                                            //     //   "${videoCategoryInx.createdAt}",
                                            //     //   style:const TextStyle(
                                            //     //       color: Colors.white,
                                            //     //       fontSize: 12,
                                            //     //       fontWeight: FontWeight.w500),
                                            //     // ),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
    );
  }
}
