// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;


import '../../const/colors.dart';
import '../../model/main_model.dart';

class NewsImages extends StatefulWidget {
  const NewsImages({
    super.key,
    required this.data,
    required this.index,
    required this.data1, 
  });

  final MainModelMain data;
  final int index;
  final List<MainModelMain> data1;

  @override
  State<NewsImages> createState() => _NewsImagesState();
}

class _NewsImagesState extends State<NewsImages> {
  int countLike = 0;
  likeButton() async {
    final url = Uri.parse(
        'https://jankoyer.com.tm/api/1.0/${widget.data.type}/like/${widget.data.id}');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Post successful');
        print(response.body);
      }
      throw (e) {
        print(e);
      };
    } catch (e) {
      print("like post error $e");
    }
  }

  viewButton() async {
    final url = Uri.parse(
        'https://jankoyer.com.tm/api/1.0/${widget.data.type}/view/${widget.data.id}');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
      }
    } catch (e) {
      print("addOrder error $e");
    }
  }

  int like = 0;
  void likeget() async {
    final url = Uri.parse('https://jankoyer.com.tm/api/1.0/${widget.data.type}/like/${widget.data.id}');
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("likes body ${response.body}");
        var res =jsonDecode(response.body)['likes'];
       like = res;
       setState(() {
         countLike = like;
       });
      }
      throw (e) {
        print(e);
      };
    } catch (e) {
      print("like post error $e");
    }
  }

  int view = 0;
  viewGet() async {
    final url = Uri.parse(
        'https://jankoyer.com.tm/api/1.0/${widget.data.type}/view/${widget.data.id}');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("views ${response.body}");
        var res =jsonDecode(response.body)['views'];
       view = res;
       setState(() {
         
       });
      }
    } catch (e) {
      print("addOrder error $e");
    }
  }


  @override
  void initState() {
    likeget();
    setState(() {
      viewButton();
    });
    viewGet();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    return Stack(
      children: [
        InkWell(
          onDoubleTap: () {
            likeButton();
            setState(() {
              countLike++;
            });
          },
          child: Container(
            color: Colors.black,
            child: Center(
              child: Image.network(
                "http://jankoyer.com.tm${widget.data.image}",
                fit: BoxFit.contain,
                // height: sizeHeight*100,
                // width: sizeWidth*100,
              ),
            ),
          ),
        ),
        Positioned(
            right: 16,
            bottom: 100,
            child: Column(
              children: [
                homeIcons("$countLike", CupertinoIcons.heart_fill, () {
                  likeButton();
                  setState(() {
                    countLike++;
                  });
                }),
                homeIcons("$view",
                    CupertinoIcons.eye_fill, () {}),
                homeIcons(
                  "",
                  Icons.share,
                  () async {
                    await FlutterShare.share(
                        title: widget.data1[widget.index].title,
                        linkUrl: '${widget.data1[widget.index].title}\n'
                            'jankoyer.com.tm/news/${widget.data1[widget.index].id}',
                        chooserTitle: 'Kim bilen paýlaşmakçy');
                  },
                )
              ],
            ))
      ],
    );
  }

  InkWell homeIcons(String text, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
          Text(
            text,
            style: const TextStyle(color: AppColors.primary, fontSize: 16),
          )
        ],
      ),
    );
  }
}
