// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../const/colors.dart';

class HomeVideoPage extends StatefulWidget {
  final String videoReportInx;
  final String title;

  const HomeVideoPage(this.videoReportInx, {super.key, required this.title});
  @override
  _HomeVideoPageState createState() => _HomeVideoPageState();
}

class _HomeVideoPageState extends State<HomeVideoPage> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.network(widget.videoReportInx),
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
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          centerTitle: true,
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: FlickVideoPlayer(
              flickVideoWithControls: FlickVideoWithControls(
                videoFit: BoxFit.fitHeight,
                controls: FlickPortraitControls(
                  progressBarSettings: FlickProgressBarSettings(),
                ),
              ),
              flickManager: flickManager,
            ),
          ),
        ));
  }
}
