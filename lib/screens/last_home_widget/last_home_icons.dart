// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;


import '../../const/colors.dart';
import '../../model/main_model.dart';

class HomeIconsWidget extends StatefulWidget {
  const HomeIconsWidget({
    super.key,
    required this.data,
    required this.index,
    required this.id,
    required this.type,
  });

  final List<MainModelMain> data;
  final int index;
  final int id;
  final String type;

  @override
  State<HomeIconsWidget> createState() => _HomeIconsWidgetState();
}

class _HomeIconsWidgetState extends State<HomeIconsWidget> {
  int countLike = 0;
  likeButton() async {
    final url = Uri.parse(
        'https://jankoyer.com.tm/api/1.0/${widget.type}/like/${widget.id}');
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
        'https://jankoyer.com.tm/api/1.0/${widget.type}/view/${widget.id}');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Post successful');
        print(response.body);
      }
    } catch (e) {
      print("addOrder error $e");
    }
  }

  @override
  void initState() {
    countLike = widget.data[widget.index].likes!;
    setState(() {
      viewButton();
    });
    super.initState();
  }

  int likecount() {
    countLike = widget.data[widget.index].likes! + 1;
    return countLike;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
            homeIcons("${widget.data[widget.index].views}",
                CupertinoIcons.eye_fill, () {}),
            homeIcons(
              "",
              Icons.share,
              () async {
                await FlutterShare.share(
                    title: widget.data[widget.index].title,
                    linkUrl: '${widget.data[widget.index].title}\n'
                        'jankoyer.com.tm/video-report/${widget.data[widget.index].id}',
                    chooserTitle: 'Kim bilen paýlaşmakçy');
              },
            )
          ],
        ));
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