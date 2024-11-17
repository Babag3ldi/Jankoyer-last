
// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:jankoyer/model/video_report_model.dart';
import 'package:video_player/video_player.dart';

import '../../const/colors.dart';

class VideoReportDetail extends StatefulWidget {
  final VideoReportModels videoReportInx;


  const VideoReportDetail(this.videoReportInx, {super.key});
  @override
  _VideoReportDetailState createState() => _VideoReportDetailState();
}

class _VideoReportDetailState extends State<VideoReportDetail> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
          "http://jankoyer.com.tm${widget.videoReportInx.video}"),
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
            widget.videoReportInx.title,
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
