import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/main_model.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({
    super.key,
    required this.data,
    required this.index,
    required this.type,
    required this.video,
  });

  final List<MainModelMain> data;
  final int index;
  final String type;
  final bool video;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 10,
        left: 16,
        right: 16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  CupertinoIcons.photo,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  type,
                  maxLines: 3,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            Text(
              data[index].time!,
              maxLines: 3,
              style: const TextStyle(
                  color: Color.fromARGB(255, 146, 142, 142), fontSize: 14),
            ),
            Text(
              data[index].title,
              maxLines: 3,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
            video == false
                ? const SizedBox()
                : SizedBox(height: MediaQuery.of(context).size.height / 100 * 4)
          ],
        ));
  }
}
