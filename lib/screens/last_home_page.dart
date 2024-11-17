// ignore_for_file: use_build_context_synchronously, avoid_print, deprecated_member_use

import 'dart:convert';

import 'package:advertising_id/advertising_id.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:new_version_plus/new_version_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../const/colors.dart';
import '../model/main_model.dart';
import '../provider/video_controller_provider.dart';
import 'last_home_widget/last_home_icons.dart';
import 'last_home_widget/last_home_image.dart';
import 'last_home_widget/last_home_title.dart';

class LastHomePage extends StatefulWidget {
  const LastHomePage({super.key});

  @override
  State<LastHomePage> createState() => _LastHomePageState();
}

class _LastHomePageState extends State<LastHomePage> {
  // String fcmToken = '';
  // String? advertisingId = '';
  // bool? isLimitAdTrackingEnabled;

  // void retrieveFCMTokenAndUUID()async {
  //   String advertisingId = '';
  //     try {
  //       advertisingId = (await AdvertisingId.id(true))!;
  //       // ignore: empty_catches
  //     } on PlatformException {
  //       advertisingId = 'Failed to get platform version.';
  //     }

  //   FirebaseMessaging.instance.getToken().then((token) {
  //     setState(() {
  //       fcmToken = token!;
  //       advertisingId = advertisingId;
  //     });
  //     print('FCM Token: $fcmToken');
  //     print('AdvertisingId: $advertisingId');   ///17525217-ab92-4fc3-b126-185edf238d3c
  //     sendFCMTokenAndUUID(fcmToken, advertisingId);
  //   });
  // }

  // Future<void> sendFCMTokenAndUUID(String fcmToken, String advertisingId) async {
  //   var url = Uri.parse('https://jankoyer.com.tm/save-token/');
  //   var headers = {'Content-Type': 'application/json'};
  //   var body = '{"token": "$fcmToken", "deviceId": "$advertisingId"}';

  //   var response = await http.put(url, headers: headers, body: body);
  //   if (response.statusCode == 200) {
  //     if (kDebugMode) {
  //       print('FCM token and UUIDv4 sent successfully');
  //     }
  //   } else {
  //     if (kDebugMode) {
  //       print('Failed to send FCM token and UUIDv4. Error: ${response.statusCode}');
  //     }
  //   }
  // }

  initPlatformState() async {
    String? advertisingId;
    bool? isLimitAdTrackingEnabled;
    try {
      advertisingId = await AdvertisingId.id(true);
    } on PlatformException {
      advertisingId = 'Failed to get platform version.';
    }

    try {
      isLimitAdTrackingEnabled = await AdvertisingId.isLimitAdTrackingEnabled;
    } on PlatformException {
      isLimitAdTrackingEnabled = false;
    }
    if (!mounted) return;

    setState(() {
      advertisingId = advertisingId!;
      isLimitAdTrackingEnabled = isLimitAdTrackingEnabled;
    });
  }

  // final _service = FirebaseNotificationService();

  String release = "";
  @override
  void initState() {
    super.initState();
    // retrieveFCMTokenAndUUID();
    // _service.connectNotification();

    getHomeItems();
    final newVersion = NewVersionPlus(
      iOSId: 'com.pikir.jankoyer',
      androidId: 'com.pikirbiz.jankoyer_new',
    );

    basicStatusCheck(newVersion);
  }

  basicStatusCheck(NewVersionPlus newVersion) async {
    final version = await newVersion.getVersionStatus();
    if (version != null) {
      release = version.releaseNotes ?? "";
      setState(() {});
    }
    newVersion.showAlertIfNecessary(
      context: context,
      launchModeVersion: LaunchModeVersion.external,
    );
  }

  advancedStatusCheck(NewVersionPlus newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);

      ///https://play.google.com/store/apps/details?id=com.pikirbiz.jankoyer_new&hl=en_US
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: 'Täze wersiýa elýeterli',
        dialogText:
            'Siziň wersiýaňyz ${status.localVersion}, täze wersiýa ${status.storeVersion}',
        updateButtonText: "Täzelemek",
        dismissButtonText: 'Häzir däl',
        launchMode: LaunchMode.externalApplication,
        allowDismissal: true,
      );
    }
  }

  List<MainModelMain> mainItemsList = [];
  bool isLoading = false;

  getHomeItems() async {
    mainItemsList = await fetchTikTokData();
  }

  Future<List<MainModelMain>> fetchTikTokData() async {
    isLoading = false;
    final response = await http.get(Uri.parse(
        'https://jankoyer.com.tm/api/1.0/main?size=1000&page=1')); //https://jankoyer.com.tm/api/1.0/main?size=1000&page=1
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['data'];
      try {
        var d = jsonData.map((item) => MainModelMain.fromJson(item)).toList();
        print(jsonData);
        isLoading = true;
        setState(() {});
        return d;
      } catch (e) {
        print("$e ======");
        throw Exception(e);
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> advertiseLink(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: AppColors.primary,
            title:
                const Text('JANKÖÝER', style: TextStyle(color: Colors.black)),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black)),
        body: SizedBox(
            child: isLoading == false
                ? const Center(child: CircularProgressIndicator())
                : PageView.builder(
                    itemCount: mainItemsList.length < 1000
                        ? mainItemsList.length
                        : 1000,
                    scrollDirection: Axis.vertical,
                    onPageChanged: (value) {
                     // Provider.of<VideoControllerProvider>(context, listen: false).disposeVideo();
                    },
                    itemBuilder: (context, index) {
                      if (mainItemsList[index].type == "image") {
                        return Stack(
                          children: [
                            ImagesGallery(
                              data: mainItemsList[index],
                              index: index,
                              data1: mainItemsList,
                            ),
                            HomeTitle(
                              data: mainItemsList,
                              index: index,
                              type: 'Surat',
                              video: false,
                            )
                          ],
                        );
                      } else if (mainItemsList[index].type == "conversation") {
                        return Stack(
                          children: [
                            VideoReportWidget(
                              data: mainItemsList[index],
                              sizeHeight: sizeHeight,
                              sizeWidth: sizeWidth,
                              type: 'conversation',
                            ),
                            HomeIconsWidget(
                              data: mainItemsList,
                              index: index,
                              id: mainItemsList[index].id!,
                              type: 'conversation',
                            ),
                            HomeTitle(
                              data: mainItemsList,
                              index: index,
                              type: 'Gepleşik',
                              video: true,
                            )
                          ],
                        );
                      } else if (mainItemsList[index].type == "videoReport") {
                        return Stack(
                          children: [
                            VideoReportWidget(
                              data: mainItemsList[index],
                              sizeHeight: sizeHeight,
                              sizeWidth: sizeWidth,
                              type: 'videoReport',
                            ),
                            HomeIconsWidget(
                              data: mainItemsList,
                              index: index,
                              id: mainItemsList[index].id!,
                              type: 'videoReport',
                            ),
                            HomeTitle(
                              data: mainItemsList,
                              index: index,
                              type: 'Wideoreportaž',
                              video: true,
                            ),
                          ],
                        );
                      } else if (mainItemsList[index].type == "short") {
                        return Stack(
                          children: [
                            VideoReportWidget(
                              data: mainItemsList[index],
                              sizeHeight: sizeHeight,
                              sizeWidth: sizeWidth,
                              type: 'short',
                            ),
                            HomeIconsWidget(
                              data: mainItemsList,
                              index: index,
                              id: mainItemsList[index].id!,
                              type: 'short',
                            ),
                            HomeTitle(
                              data: mainItemsList,
                              index: index,
                              type: 'Short',
                              video: true,
                            ),
                          ],
                        );
                      } else if (mainItemsList[index].type == "news") {
                        return Stack(
                          children: [
                            ImagesGallery(
                              data: mainItemsList[index],
                              index: index,
                              data1: mainItemsList,
                            ),
                            HomeTitle(
                              data: mainItemsList,
                              index: index,
                              type: 'Täzelik',
                              video: false,
                            )
                          ],
                        );
                      } else if (mainItemsList[index].type == "advertise") {
                        return InkWell(
                          onTap: () {
                            advertiseLink(
                                Uri.parse("${mainItemsList[index].link}"));
                          },
                          child: Center(
                            child: Image.network(
                                "http://jankoyer.com.tm${mainItemsList[index].image}",
                                width: sizeWidth * 100,
                                height: sizeHeight * 100,
                                fit: BoxFit.fill),
                          ),
                        );
                      }
                      return null;
                    })));
  }
}

class VideoReportWidget extends StatefulWidget {
  const VideoReportWidget({
    super.key,
    required this.data,
    required this.sizeHeight,
    required this.sizeWidth,
    required this.type,
  });

  final MainModelMain data;
  final double sizeHeight;
  final double sizeWidth;
  final String type;

  @override
  State<VideoReportWidget> createState() => _VideoReportWidgetState();
}

class _VideoReportWidgetState extends State<VideoReportWidget>
    with WidgetsBindingObserver {
 // late FlickManager flickManager;
 late VideoControllerProvider _appProvider;
  @override
  void didChangeDependencies() {
    _appProvider = Provider.of<VideoControllerProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _appProvider.disposeVideo();
     print("dispose video");
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    print("video init"
    );
     Provider.of<VideoControllerProvider>(context, listen: false).init(widget.data.video!);
    // flickManager = FlickManager(
    //     videoPlayerController: VideoPlayerController.network(
    //         "http://jankoyer.com.tm${}"));
  }

  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 100 * 100,
      height: MediaQuery.of(context).size.height / 100 * 100,
      color: Colors.black,
      child: Center(
        child: FlickVideoPlayer(
           wakelockEnabled:false,
            flickVideoWithControls: FlickVideoWithControls(
                videoFit: BoxFit.contain,
               
                willVideoPlayerControllerChange: false,
                controls: FlickPortraitControls(
                    progressBarSettings: FlickProgressBarSettings())),
            flickManager: Provider.of<VideoControllerProvider>(context).flickManager!),
      ),
    );
  }
}
