import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoControllerProvider with ChangeNotifier{
   FlickManager? flickManager;
   init(String video){
//    if (flickManager!=null) {flickManager!.dispose(); 
    flickManager= FlickManager(
        videoPlayerController: VideoPlayerController.network(
            "http://jankoyer.com.tm$video"));
   }
   

  disposeVideo(){
    try{
    print("geldi su");
    if (flickManager!=null){
    flickManager!.flickControlManager!.autoPause();
     flickManager!.dispose();
   
    notifyListeners();
    }
    } catch (e){
      print("e");
    }
  }
}