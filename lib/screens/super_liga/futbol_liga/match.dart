// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jankoyer/const/colors.dart';

import '../../../model/championat_model.dart';
import '../../../model/futbol_match_model.dart';
import 'package:http/http.dart' as http;

import 'players_page.dart';

class FutbolMatchPage extends StatefulWidget {
  const FutbolMatchPage(this.championatsget, {super.key});

  final ChampionatModel championatsget;

  @override
  State<FutbolMatchPage> createState() => _FutbolMatchPageState();
}

class _FutbolMatchPageState extends State<FutbolMatchPage> {
  late List<MatchModelMatches> matcheses;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    matcheses = await getMatches();
    setState(() {
      isLoading = false;
    });
  }

  Future<List<MatchModelMatches>> getMatches() async {
    final uri = Uri.parse(
        "http://jankoyer.com.tm/api/1.0/game/last/${widget.championatsget.id}/");
    var response = await http.get(uri);
    var json = jsonDecode(response.body) as List;
    if (response.statusCode == 200) {
      List<MatchModelMatches> matches = List<MatchModelMatches>.from(
          json.map((e) => MatchModelMatches.fromJson(e)));
      return matches;
    } else {
      String matches = 'no internet';
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Center(
            child: SizedBox(
                width: sizeWidth * 93,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: matcheses.length,
                    itemBuilder: (context, inx) {
                      int index = matcheses.length - 1 - inx;
                      final match = matcheses[index];
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(match.title,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            SizedBox(height: sizeHeight * 2),
                            Column(
                                children: List<Widget>.from(
                                    matcheses[index].matches.map((fmatch) {
                              final getPlayers = fmatch.firstClub!.club;
                              final getPlayersSecond = fmatch.secondClub!.club;
                              return Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Container(
                                      height: sizeHeight * 12,
                                      decoration: BoxDecoration(
                                          color: AppColors.tabPossive,
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  PlayersPage(
                                                                      getPlayers
                                                                          .id,
                                                                      name: getPlayers
                                                                          .clubName)),
                                                        );
                                                      },
                                                      child: Column(children: [
                                                        SizedBox(
                                                          height:
                                                              sizeHeight * 6,
                                                          width: sizeWidth * 10,
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: getPlayers
                                                                .image,
                                                            placeholder: (context,
                                                                    url) =>
                                                                const CircularProgressIndicator(),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .error),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: sizeWidth *
                                                                27,
                                                            child: Text(
                                                                getPlayers
                                                                    .clubName,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        14),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center))
                                                      ])),
                                                  SizedBox(
                                                      width: sizeWidth * 15,
                                                      height: sizeHeight * 8.3,
                                                      child: InkWell(
                                                          onTap: () {
                                                            showDialog<void>(
                                                                context:
                                                                    context,
                                                                barrierDismissible:
                                                                    true,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                      scrollable:
                                                                          true,
                                                                      backgroundColor:
                                                                          AppColors
                                                                              .background,
                                                                      title: const Text(
                                                                          'Oýunyň netijeleri',
                                                                          style:
                                                                              TextStyle(color: Colors.white)),
                                                                      content: SizedBox(
                                                                          height: sizeHeight * 30,
                                                                          width: sizeWidth * 95,
                                                                          child: SingleChildScrollView(
                                                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                            Text(getPlayers.clubName,
                                                                                style: const TextStyle(color: Colors.white)),
                                                                            SizedBox(height: sizeHeight * 1),
                                                                            Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: List<Widget>.from(fmatch.firstClub!.resultGoals.map((resultt) => Row(children: [
                                                                                      Text(
                                                                                        "${resultt.player!.fullName}${resultt.minute}`",
                                                                                        maxLines: 1,
                                                                                        style: const TextStyle(color: Colors.white, fontSize: 12),
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        width: 5,
                                                                                      ),
                                                                                      SizedBox(height: 15, child: Image.asset('assets/images/ball.png'))
                                                                                    ])))),
                                                                            SizedBox(height: sizeHeight * 1),
                                                                            Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: List<Widget>.from(fmatch.firstClub!.resultCards.map((resultt) => SingleChildScrollView(
                                                                                    scrollDirection: Axis.horizontal,
                                                                                    child: Row(children: [
                                                                                      Text("${resultt.player.fullName}  ${resultt.minute}`", style: const TextStyle(color: Colors.white, fontSize: 12)),
                                                                                      Row(
                                                                                          children: List.from(resultt.cardd.map((e) {
                                                                                        return Padding(padding: const EdgeInsets.all(2.0), child: Container(height: 15, width: 8, decoration: BoxDecoration(color: e == Cardd.RED ? Colors.red : Colors.yellow, borderRadius: BorderRadius.circular(2))));
                                                                                      }).toList()))
                                                                                    ]))))),
                                                                            SizedBox(height: sizeHeight * 2),
                                                                            const Divider(color: AppColors.primary),
                                                                            Text(getPlayersSecond.clubName,
                                                                                style: const TextStyle(color: Colors.white)),
                                                                            SizedBox(height: sizeHeight * 1),
                                                                            Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: List<Widget>.from(fmatch.secondClub!.resultGoals.map((resultt) => Row(children: [
                                                                                      Text("${resultt.player!.fullName}${resultt.minute}`", maxLines: 1, style: const TextStyle(color: Colors.white, fontSize: 12)),
                                                                                      const SizedBox(width: 5),
                                                                                      SizedBox(height: 15, child: Image.asset('assets/images/ball.png'))
                                                                                    ])))),
                                                                            SizedBox(height: sizeHeight * 1),
                                                                            Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: List<Widget>.from(fmatch.secondClub!.resultCards.map((resultt) => SingleChildScrollView(
                                                                                    scrollDirection: Axis.horizontal,
                                                                                    child: Row(children: [
                                                                                      Text("${resultt.player.fullName}  ${resultt.minute}`", style: const TextStyle(color: Colors.white, fontSize: 12)),
                                                                                      Row(
                                                                                          children: List.from(resultt.cardd.map((e) {
                                                                                        return Padding(
                                                                                            padding: const EdgeInsets.all(2.0),
                                                                                            child: Container(
                                                                                              height: 15,
                                                                                              width: 8,
                                                                                              decoration: BoxDecoration(color: e == Cardd.RED ? Colors.red : Colors.yellow, borderRadius: BorderRadius.circular(2)),
                                                                                            ));
                                                                                      }).toList()))
                                                                                    ])))))
                                                                          ]))),
                                                                      actionsAlignment: MainAxisAlignment.center,
                                                                      actions: <Widget>[
                                                                        TextButton(
                                                                            child:
                                                                                const Text('Aýyrmak', style: TextStyle(color: AppColors.primary)),
                                                                            onPressed: () {
                                                                              Navigator.of(context).pop();
                                                                            })
                                                                      ]);
                                                                });
                                                          },
                                                          child:
                                                              Stack(children: [
                                                            Container(
                                                                height:
                                                                    sizeHeight *
                                                                        7.5,
                                                                width:
                                                                    sizeWidth *
                                                                        15,
                                                                decoration: BoxDecoration(
                                                                    color: AppColors.background,
                                                                    borderRadius: BorderRadius.circular(50.0),
                                                                    border: Border.all(
                                                                        color: fmatch.status == MatchStatus.END
                                                                            ? Colors.red
                                                                            : fmatch.status == MatchStatus.LIVE
                                                                                ? AppColors.primary
                                                                                : Colors.white,
                                                                        width: 2.5)),
                                                                child: Center(
                                                                    child: Text(
                                                                        fmatch.status == MatchStatus.WAIT
                                                                            ? "${(fmatch.schedule.hour + 5)}:${fmatch.schedule.minute > 10 ? fmatch.schedule.minute : "${fmatch.schedule.minute}0"}"
                                                                            // DateTime.parse(
                                                                            //       fmatch.schedule.toString(),
                                                                            //     ).hour.toString()
                                                                            // DateTime.parse(
                                                                            //   fmatch.schedule.toString(),
                                                                            // ).minute.toString()
                                                                            : "${fmatch.firstClub!.resultGoals.length}:${fmatch.secondClub!.resultGoals.length}",
                                                                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)))),
                                                            Positioned(
                                                                bottom: 0,
                                                                right: 7,
                                                                left: 7,
                                                                child: Container(
                                                                    height: sizeHeight * 1.8,
                                                                    width: sizeWidth * 13,
                                                                    decoration: BoxDecoration(
                                                                        color: fmatch.status == MatchStatus.END
                                                                            ? Colors.red
                                                                            : fmatch.status == MatchStatus.LIVE
                                                                                ? AppColors.primary
                                                                                : Colors.white,
                                                                        borderRadius: BorderRadius.circular(5.0)),
                                                                    child: Center(
                                                                        child: Text(
                                                                            '${DateTime.parse(
                                                                              fmatch.schedule.toString(),
                                                                            ).day}.${DateTime.parse(
                                                                              fmatch.schedule.toString(),
                                                                            ).month}.${DateTime.parse(
                                                                              fmatch.schedule.toString(),
                                                                            ).year}',
                                                                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 9)))))
                                                          ]))),
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    PlayersPage(
                                                                        getPlayersSecond
                                                                            .id,
                                                                        name: getPlayersSecond
                                                                            .clubName)));
                                                      },
                                                      child: Column(children: [
                                                        SizedBox(
                                                            height:
                                                                sizeHeight * 6,
                                                            width:
                                                                sizeWidth * 10,
                                                            child: CachedNetworkImage(
                                                                imageUrl:
                                                                    getPlayersSecond
                                                                        .image,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    const CircularProgressIndicator(),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    const Icon(Icons
                                                                        .error))),
                                                        SizedBox(
                                                            width:
                                                                sizeWidth * 27,
                                                            child: Text(
                                                                getPlayersSecond
                                                                    .clubName,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        14),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center))
                                                      ]))
                                                ])
                                          ])));
                            })))
                          ]);
                    })));
  }
}
