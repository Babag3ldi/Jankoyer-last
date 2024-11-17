// ignore_for_file: unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jankoyer/const/colors.dart';

import '../../../model/championat_model.dart';
import '../../../model/futbol_statistika_model.dart';
import 'package:http/http.dart' as http;

class FutbolStatistikaPage extends StatefulWidget {
  const FutbolStatistikaPage(this.champ, {super.key});

  final ChampionatModel champ;

  @override
  State<FutbolStatistikaPage> createState() => _FutbolStatistikaPageState();
}

class _FutbolStatistikaPageState extends State<FutbolStatistikaPage> {
  late List<StatisticModelMatches> statistica;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    statistica = await getStatistic();
    setState(() {
      isLoading = false;
    });
  }

  Future<List<StatisticModelMatches>> getStatistic() async {
    final uri = Uri.parse(
        "http://jankoyer.com.tm/api/1.0/game/table/player/${widget.champ.id}?limit=10");
    var response = await http.get(uri);
    print("matchGet => ${response.statusCode}");
    var json = jsonDecode(response.body) as List;
    if (response.statusCode == 200) {
      List<StatisticModelMatches> statis = List<StatisticModelMatches>.from(
          json.map((e) => StatisticModelMatches.fromJson(e)));
      return statis;
    } else {
      String statis = 'no internet';
    }
    return [];
    //  throw "Internet baglansygy yok";
  }

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Center(
            child: SizedBox(
              width: sizeWidth * 91,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: sizeWidth * 91,
                    height: sizeHeight * 3,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "GOLLAR",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: statistica.length,
                      itemBuilder: (context, index) {
                        StatisticModelMatches stat = statistica[index];
                        return Container(
                            alignment: Alignment.center,
                            height: sizeHeight * 6,
                            decoration: const BoxDecoration(
                              color: AppColors.tabPossive,
                            ),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: sizeWidth * 8,
                                  child: Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: sizeWidth * 10,
                                  child: Center(
                                    child: CircleAvatar(
                                      radius: 20.0,
                                      backgroundImage: NetworkImage(
                                          "http://jankoyer.com.tm${stat.player.image}"),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: sizeWidth * 3,
                                ),
                                SizedBox(
                                  width: sizeWidth * 60,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        stat.player.fullName,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                              height: sizeHeight * 1.5,
                                              child: Image.network(
                                                  "http://jankoyer.com.tm${stat.player.club.image}")),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            stat.player.club.clubName,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "${stat.totalGoals}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ],
                            ));
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 0,
                          thickness: 1,
                          color: AppColors.primary,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}




// SizedBox(height: sizeHeight*2,),
//             Container(
//               alignment: Alignment.centerLeft,
//               width: sizeWidth * 91,
//               height: sizeHeight * 3,
//               decoration: const BoxDecoration(
//                 color: AppColors.primary,
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.only(left: 10.0),
//                 child: Text(
//                   "GOLLOWOÝ PASLAR",
//                   style: TextStyle(fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: ListView.separated(
//                 physics: BouncingScrollPhysics(),
//                 padding: EdgeInsets.zero,
//                 itemCount: gollarModelList.length,
//                 itemBuilder: (context, index) {
//                   FutbolStatistikaGollarModel getFotbolStatistikGollarModel =
//                       gollarModelList[index];
//                   return Container(
//                       alignment: Alignment.center,
//                       height: sizeHeight * 6,
//                       decoration: const BoxDecoration(
//                         color: AppColors.tabPossive,
//                       ),
//                       child: Row(
//                         // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           SizedBox(
//                             width: sizeWidth * 8,
//                             child: Center(
//                               child: Text(
//                                 '${index + 1}',
//                                 style: const TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 16),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: sizeWidth * 10,
//                             child: Center(
//                               child: CircleAvatar(
//                                 radius: 20.0,
//                                 backgroundImage: AssetImage(
//                                     getFotbolStatistikGollarModel.image),
//                                 backgroundColor: Colors.transparent,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: sizeWidth * 3,
//                           ),
//                           SizedBox(
//                             width: sizeWidth * 60,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   getFotbolStatistikGollarModel.name,
//                                   style: const TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 16),
//                                 ),
//                                 Row(
//                                   children: [
//                                     SizedBox(
//                                         height: sizeHeight * 1.5,
//                                         child: Image.asset(
//                                             getFotbolStatistikGollarModel
//                                                 .teamLogo)),
//                                     Text(
//                                       getFotbolStatistikGollarModel.team,
//                                       style: const TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: 12),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Text(
//                             "${getFotbolStatistikGollarModel.score}",
//                             style: const TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 16),
//                           ),
//                         ],
//                       ));
//                 },
//                 separatorBuilder: (context, index) {
//                   return const Divider(
//                     height: 0,
//                     thickness: 1,
//                     color: AppColors.primary,
//                   );
//                 },
//               ),
//             ),