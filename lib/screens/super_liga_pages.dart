// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:jankoyer/const/colors.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../provider/championat_provider.dart';
import 'super_liga/futbol_liga_page.dart';

class SuperLigaPages extends StatefulWidget {
  const SuperLigaPages({super.key});

  @override
  State<SuperLigaPages> createState() => _SuperLigaPagesState();
}

class _SuperLigaPagesState extends State<SuperLigaPages> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ChampionatProvider>(context, listen: false)
          .championatGetAll();
    });
    Future.delayed(const Duration(milliseconds: 3000), () {
      // if (!mounted) {
      //   return;
      // }
      @override
      void dispose(mounted) {
        isLoading3 = true;
        super.dispose();
      }
      // setState(() {
      //   isLoading3 = true;
      // });
    });
  }

  bool isLoading3 = false;

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text('Netijeler', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Consumer<ChampionatProvider>(builder: (context, value, child) {
        if (value.isLoading3) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[500]!,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: 2,
                itemBuilder: ((context, index) {
                  // NewsModel getNewsModel = newsModel[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Container(
                        width: sizeWidth * 91,
                        alignment: Alignment.bottomCenter,
                        height: sizeHeight * 37,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(32, 247, 245, 245)
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  );
                })),
          );
        }
        final championats = value.championat;
        return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: championats.length,
            itemBuilder: ((context, index) {
              // NewsModel getNewsModel = newsModel[index];
              final championatsget = championats[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: InkWell(
                    onTap: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FutbolLigaPage(championatsget)),
                      );
                    }),
                    child: Container(
                      width: sizeWidth * 91,
                      alignment: Alignment.bottomCenter,
                      height: sizeHeight * 37,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(32, 247, 245, 245)
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5.0),
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                const Color.fromARGB(255, 216, 213, 213)
                                    .withOpacity(0.9),
                                BlendMode.modulate,
                              ),
                              image: NetworkImage(
                                "http://jankoyer.com.tm${championatsget.image}",
                              ),
                              fit: BoxFit.fill)),
                      // child: Padding(
                      //   padding: EdgeInsets.all(15.0),
                      //   child: Text(
                      //     "${championatsget.title}",
                      //     style: const TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.w500),
                      //   ),
                      // ),
                    ),
                  ),
                ),
              );
            }));
      }),
    );
  }
}

// class LigaModel extends StatelessWidget {
//             // LigaModel(sizeWidth: sizeWidth, sizeHeight: sizeHeight),
//   const LigaModel({
//     Key? key,
//     required this.sizeWidth,
//     required this.sizeHeight,
//   }) : super(key: key);

//   final double sizeWidth;
//   final double sizeHeight;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Center(
//         child: Container(
//           width: sizeWidth * 91,
//           child: ListView.builder(
//               itemCount: ligaList.length,
//               itemBuilder: (context, index) {
//                 LigaModel getLigaModel = ligaList[index];
//                 return InkWell(
//                    onTap: (() {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => NewsDetails(getNewsModel)),
//               );
//             }),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: Container(
//                       alignment: Alignment.bottomCenter,
//                       height: sizeHeight * 37,
//                       decoration: BoxDecoration(
//                           color: Color.fromARGB(32, 247, 245, 245)
//                               .withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(5.0),
//                           image: DecorationImage(
//                               image: AssetImage(
//                                 getLigaModel.image,
//                               ),
//                               fit: BoxFit.fill)),
//                       child: Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: Text(
//                           getLigaModel.title,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//         ),
//       ),
//     );
//   }
// }
