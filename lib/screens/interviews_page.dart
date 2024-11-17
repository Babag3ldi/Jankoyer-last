// ignore_for_file: unused_field, unused_element

import 'package:flutter/material.dart';
import 'package:jankoyer/const/colors.dart';
import 'package:jankoyer/screens/details_pages/video_details.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../provider/interviews.dart';

class InterviewsPage extends StatefulWidget {
  const InterviewsPage({super.key});

  @override
  State<InterviewsPage> createState() => _InterviewsPageState();
}

class _InterviewsPageState extends State<InterviewsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<InterviewsProvider>(context, listen: false)
          .interviewsGetAll();
    });
    Future.delayed(const Duration(milliseconds: 3000), () {
      @override
      void dispose(mounted) {
        isLoading = true;
        super.dispose();
      }
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primary,
          title:
              const Text('Gepleşikler', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Consumer<InterviewsProvider>(builder: (context, value, child) {
        if (value.isLoading) {
          return Center(
            child: SizedBox(
              width: sizeWidth * 91,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[800]!,
                highlightColor: Colors.grey[500]!,
                child: ListView.builder(itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      height: sizeHeight * 21,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(32, 247, 245, 245)
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Stack(
                        children: [
                          Container(width: sizeWidth * 91),
                          Positioned(
                            bottom: 0,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[800]!,
                              highlightColor: Colors.grey[500]!,
                              child: Container(
                                width: sizeWidth * 91,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          );
        }
        final interviews = value.interviews;
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Center(
            child: SizedBox(
              width: sizeWidth * 91,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: interviews.length,
                  itemBuilder: (context, index) {
                    // InterviewsModel getinterviewsModel = interviewsModel[index];
                    final interviewsInx = interviews[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        height: sizeHeight * 21,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(32, 247, 245, 245)
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: (() {
                                pushNewScreen(
                                  context,
                                  screen: VideoApp(interviewsInx),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              }),
                              child: SizedBox(
                                  width: sizeWidth * 91,
                                  child: Image.network(
                                      "http://jankoyer.com.tm${interviewsInx.image}",
                                      color: const Color.fromARGB(
                                              255, 155, 154, 154)
                                          .withOpacity(0.9),
                                      colorBlendMode: BlendMode.modulate,
                                      fit: BoxFit.fill)),
                            ),
                            InkWell(
                              onTap: (() {
                                pushNewScreen(
                                  context,
                                  screen: VideoApp(interviewsInx),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              }),
                              child: Center(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: sizeHeight * 4.5,
                                  width: sizeWidth * 11,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border:
                                          Border.all(color: AppColors.primary)),
                                  child: const Icon(
                                    Icons.play_arrow_outlined,
                                    color: AppColors.primary,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: sizeWidth * 91,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${interviewsInx.title}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.history,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "${interviewsInx.videoDuration}",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        );
      }),
    );
  }
}
