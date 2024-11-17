// ignore_for_file: unused_element, avoid_print

import 'dart:convert';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jankoyer/model/gallery_model.dart';
import 'package:http/http.dart' as http;

import '../../const/colors.dart';
import '../../model/gallery_details_model.dart';
import '../../widgets/image_zoom.dart';

class GalleryDetails extends StatefulWidget {
  const GalleryDetails(this.galleryInx, {super.key, });
  final Gallery galleryInx;

  @override
  State<GalleryDetails> createState() => _GalleryDetailsState();
}

class _GalleryDetailsState extends State<GalleryDetails> {
  // late List<GalleryDetailsModel> galleryeDetail;
  // bool isLoading = true;

  late ScrollController _controller;
  int _page = 1;
  final int _limit = 5;
  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  List galleryList = [];

 
  @override
  void initState() {
    super.initState();
    // fetch();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  Future<List<GalleryDetailsModel>> _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });

      _page += 1;

      try {
        final res = await http.get(Uri.parse(
            "http://jankoyer.com.tm/api/1.0/gallery/attachments/${widget.galleryInx.id}?page=$_page&size=$_limit"));
        if (res.statusCode == 200) {
          final dynamic json = jsonDecode(res.body);
          final  neww = json['gallery'] as List;
          print(res.statusCode);
          final news = neww.map((e) {
            return GalleryDetailsModel(
              id: e['id'],
              image: e['image'],
              // createdAt: e['createdAt'],
              galleryId: e['galleryId'],
              // updatedAt: e['updatedAt'],
            );
          }).toList();
          if (news.isNotEmpty) {
            setState(() {
              galleryList.addAll(news);
            });
          } else {
            setState(() {
              _hasNextPage = false;
            });
          }
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
    return [];
  }

  Future<List<GalleryDetailsModel>> _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      final res = await http.get(Uri.parse(
          "http://jankoyer.com.tm/api/1.0/gallery/attachments/${widget.galleryInx.id}?page=$_page&size=$_limit"));
          
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        final neww = json['gallery'] as List;
        print(res.statusCode);
        setState(() {
          galleryList = neww.map((e) {
            return GalleryDetailsModel(
              id: e['id'],
              image: e['image'],
              galleryId: e['galleryId'],
            );
          }).toList();
        });
        
      }
    } catch (err) {
      if (kDebugMode) {
        print('Wrong $err');
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
    return [];
  }

  // fetch() async {
  //   galleryeDetail = await getgallery();
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // Future<List<GalleryAttachment>> getgallery() async {
  //   final uri = Uri.parse(
  //       "http://jankoyer.com.tm/api/1.0/gallery/${widget.galleryInx.id}");
  //   var response = await http.get(uri);
  //   var json = jsonDecode(response.body)['galleryAttachments'] as List;
  //   if (response.statusCode == 200) {
  //     List<GalleryAttachment> gallery = List<GalleryAttachment>.from(
  //         json.map((e) => GalleryAttachment.fromJson(e)));
  //     return gallery;
  //   } else {
  //     String gallery = 'no internet';
  //   }
  //   return [];
  // }

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          widget.galleryInx.title,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _isFirstLoadRunning
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Center(
                child: SizedBox(
                  width: sizeWidth * 91,
                  child: ListView.builder(
                      controller: _controller,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(top: 10),
                      itemCount: galleryList.length,
                      itemBuilder: (context, index) {
                        final galleryInx2 = galleryList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: InkWell(
                            onTap: () {
                              CustomImageProvider customImageProvider =
                                  CustomImageProvider(
                                      initialIndex: index,
                                      imageUrls: List.from(galleryList.map((e) =>
                                          "http://jankoyer.com.tm${e.image}")));
                              showImageViewerPager(
                                  backgroundColor: AppColors.tabPossive,
                                  context,
                                  customImageProvider,
                                  doubleTapZoomable: true,
                                  swipeDismissible: true,
                                  onPageChanged: (page) {},
                                  onViewerDismissed: (page) {});
                            },
                            child: Container(
                              height: sizeHeight * 27,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 77, 77, 77),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  // image: DecorationImage(
                                  //     image: NetworkImage(
                                  //       "http://jankoyer.com.tm${galleryInx2.image}",
                                  //     ),
                                  //     fit: BoxFit.fill)
                                ),
                                width: sizeWidth * 91,
                                child:  Image.network("http://jankoyer.com.tm${galleryInx2.image}",),
                                // child: CachedNetworkImage(
                                //   fit: BoxFit.fill,
                                //   imageUrl:
                                //       "https://jankoyer.com.tm${galleryList[index].}",
                                //   placeholder: (context, url) => const Center(
                                //       child: SizedBox(
                                //           height: 40,
                                //           child: CircularProgressIndicator())),
                                //   errorWidget: (context, url, error) =>
                                //       const Icon(Icons.error),
                                // ),
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
