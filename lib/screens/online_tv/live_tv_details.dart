// ignore_for_file: deprecated_member_use

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'live_tv_model.dart';

class LiveTVDetails extends StatefulWidget {
  const LiveTVDetails( this.tv, {Key? key} ) : super(key: key);

  final LiveTVModel tv;

  @override
  State<LiveTVDetails> createState() => _LiveTVDetailsState();
}

class _LiveTVDetailsState extends State<LiveTVDetails> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
          widget.tv.video),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 41, 41),
        appBar: AppBar(
          backgroundColor: const Color(0xFFB5EC17),//AppColors.primary,
          centerTitle: true,
          title: Text(
            widget.tv.title,
            style: const TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: FlickVideoPlayer(
              
              flickManager: flickManager,
            ),
          ),
        ));
  }
}
