import 'package:flutter/material.dart';

import '../const/colors.dart';
import 'gallery/gallery_page.dart';
import 'interviews_page.dart';
import 'online_tv/live_tv_screen.dart';
import 'video_report/video_report_category.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({super.key});

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Media',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: sizeHeight * 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InterviewsPage()),
                  );
                },
                child: Container(
                  height: sizeHeight * 13,
                  width: sizeWidth * 91,
                  decoration: BoxDecoration(
                      color: AppColors.tabPossive,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Gepleşikler',
                            style:  TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                        // ClipRRect(
                        //   borderRadius: const BorderRadius.only(
                        //       topRight: Radius.circular(5),
                        //       bottomRight: Radius.circular(5)),
                        //   child: SizedBox(
                        //     height: sizeHeight * 13,
                        //     width: 140,
                        //     child: Image.network(
                        //       'http://jankoyer.com.tm${shopInx.image}',
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // )
                      ]),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GalleryPage()),
                  );
                },
                child: Container(
                  height: sizeHeight * 13,
                  width: sizeWidth * 91,
                  decoration: BoxDecoration(
                      color: AppColors.tabPossive,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Fotoreportaž',
                            style:  TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VideoReportCategoryPage()),
                  );
                },
                child: Container(
                  height: sizeHeight * 13,
                  width: sizeWidth * 91,
                  decoration: BoxDecoration(
                      color: AppColors.tabPossive,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Wideoreportaž',
                            style: TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                        // ClipRRect(
                        //   borderRadius: const BorderRadius.only(
                        //       topRight: Radius.circular(5),
                        //       bottomRight: Radius.circular(5)),
                        //   child: SizedBox(
                        //     height: sizeHeight * 13,
                        //     width: 140,
                        //     child: Image.network(
                        //       'http://jankoyer.com.tm${shopInx.image}',
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // )
                      ]),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LiveTVScreen()),
                  );
                },
                child: Container(
                  height: sizeHeight * 13,
                  width: sizeWidth * 91,
                  decoration: BoxDecoration(
                      color: AppColors.tabPossive,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Online Tv',
                            style: TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                        // ClipRRect(
                        //   borderRadius: const BorderRadius.only(
                        //       topRight: Radius.circular(5),
                        //       bottomRight: Radius.circular(5)),
                        //   child: SizedBox(
                        //     height: sizeHeight * 13,
                        //     width: 140,
                        //     child: Image.network(
                        //       'http://jankoyer.com.tm${shopInx.image}',
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // )
                      ]),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
