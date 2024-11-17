// ignore_for_file: unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jankoyer/const/colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/advertise_model.dart';
import '../model/news_model.dart';
import '../widgets/carusel.dart';
import 'details_pages/news_details.dart';
import 'package:http/http.dart' as http;

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override 
  void initState() {
    super.initState();
    fetch();
    fetchData();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  bool isLoading3 = false;
  final _baseUrl = 'http://jankoyer.com.tm/api/1.0/news';

  int _page = 1;

  final int _limit = 10;

  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;

  bool _isLoadMoreRunning = false;

  List _posts = [];

  Future<List<NewsModelNewsNews>> _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });

      _page += 1;

      try {
        final res =
            await http.get(Uri.parse("$_baseUrl?page=$_page&size=$_limit"));
        if (res.statusCode == 200) {
          final json = jsonDecode(res.body);
          final neww = json['news'] as List;
          final news = neww.map((e) {
            return NewsModelNewsNews(
              id: e['id'],
              title: e['title'],
              image: e['image'],
              views: e['views'],
              smallImage: e['smallImage'],
              description: e['description'],
            );
          }).toList();
          if (news.isNotEmpty) {
            setState(() {
              _posts.addAll(news);
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

  Future<List<NewsModelNewsNews>> _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      final res =
          await http.get(Uri.parse("$_baseUrl?page=$_page&size=$_limit"));
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        final neww = json['news'] as List;
        setState(() {
          _posts = neww.map((e) {
            return NewsModelNewsNews(
              id: e['id'],
              title: e['title'],
              image: e['image'],
              views: e['views'],
              smallImage: e['smallImage'],
              description: e['description'],
            );
          }).toList();
        });
      }
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
    return [];
  }

  late ScrollController _controller;
  Future<List<AdvertiseModel>> fetchData() async {
    var url = Uri.parse('http://jankoyer.com.tm/api/1.0/advertise?type=0');
    final response = await http.get(url);
    print("news status ${response.statusCode}");
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => AdvertiseModel.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  bool isLoading = true;

  late List<AdvertiseModel> matcheses;
  fetch() async {
    matcheses = await getMatches();
    setState(() {
      isLoading = false;
    });
  }

  Future<List<AdvertiseModel>> getMatches() async {
    final uri = Uri.parse("http://jankoyer.com.tm/api/1.0/advertise?type=0");
    var response = await http.get(uri);
    var json = jsonDecode(response.body) as List;
    print("news status ${response.statusCode}  $json");
    if (response.statusCode == 200) {
      List<AdvertiseModel> matches = List<AdvertiseModel>.from(
          json.map((e) => AdvertiseModel.fromJson(e)));
      return matches;
    } else {
      String matches = 'no internet';
    }
    return [];
    //  throw "Internet baglansygy yok";
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
    return Column(
      children: [
        SizedBox(height: sizeHeight * 2.8),
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            'Powered by Pikir.',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          child: FutureBuilder<List<AdvertiseModel>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? CaruselList(
                      list: snapshot.data!,
                    )
                  : Shimmer.fromColors(
                      baseColor: Colors.grey[800]!,
                      highlightColor: Colors.grey[500]!,
                      child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(32, 247, 245, 245)
                              .withOpacity(0.2),
                        ),
                      ));
            },
          ),
        ),
        _isFirstLoadRunning
            ? Expanded(
                child: SizedBox(
                  width: sizeWidth * 91,
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[800]!,
                        highlightColor: Colors.grey[500]!,
                        child: SizedBox(
                          width: sizeWidth * 91,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              height: sizeHeight * 28,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(32, 247, 245, 245)
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: sizeWidth * 91,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[800]!,
                        highlightColor: Colors.grey[500]!,
                        child: SizedBox(
                          width: sizeWidth * 91,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              height: sizeHeight * 28,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(32, 247, 245, 245)
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: sizeWidth * 91,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[800]!,
                        highlightColor: Colors.grey[500]!,
                        child: SizedBox(
                          width: sizeWidth * 91,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              height: sizeHeight * 28,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(32, 247, 245, 245)
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: sizeWidth * 91,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: sizeWidth * 91,
                        child: ListView.separated(
                          controller: _controller,
                          // shrinkWrap: true,
                          itemCount: _posts.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (_, index) {
                            final neww = _posts[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: InkWell(
                                  onTap: (() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NewsDetails(neww)),
                                    );
                                  }),
                                  child: Container(
                                    alignment: Alignment.bottomLeft,
                                    height: sizeHeight * 28,
                                    decoration: BoxDecoration(
                                        color: AppColors.tabPossive,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              "http://jankoyer.com.tm${neww.smallImage}",
                                            ),
                                            fit: BoxFit.fill)),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      width: sizeWidth * 91,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5)),
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          "${neww.title}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  )),
                            );
                          },
                          separatorBuilder: (_, index) {
                            //  index < matcheses.length
                            // int newIndex = index % 5;
                            if ((index + 6) % 4 == 0) {
                              // if(index ~/ 5 == 0) {

                              int nextIndex = index % matcheses.length.toInt();
                              // final adver = matcheses[nextIndex];
                              return Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 20, top: 10),
                                child: InkWell(
                                  onTap: () {
                                    // _advertiseLink("${matcheses[nextIndex].link}");
                                    setState(() {
                                      _advertiseLink(Uri.parse(
                                          "${matcheses[nextIndex].link}"));
                                    });
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           AdvertisePage(adver)),
                                    // );
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: AppColors.tabPossive,
                                    ),
                                    height: sizeHeight * 10,
                                    child: Image.network(
                                        "http://jankoyer.com.tm${matcheses[nextIndex].image}",
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox(
                              height: 0,
                              width: 0,
                            );
                          },
                        ),
                      ),
                    ),
                    if (_isLoadMoreRunning == true)
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 40),
                        child: SizedBox(),
                      ),
                    if (_hasNextPage == false) const Center(),
                  ],
                ),
              ),
      ],
    );
  }

  Shimmer getShimmerLoading(double sizeHeight) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: sizeHeight * 21,
          decoration: BoxDecoration(
            color: const Color.fromARGB(32, 247, 245, 245).withOpacity(0.2),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ));
  }
}
