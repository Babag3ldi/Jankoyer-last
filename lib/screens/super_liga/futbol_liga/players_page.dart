// ignore_for_file: unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jankoyer/const/colors.dart';
import 'package:jankoyer/model/players_model.dart';

import 'package:http/http.dart' as http;

class PlayersPage extends StatefulWidget {
  const PlayersPage(this.id, {super.key, required this.name});

  final int  id;
  final String name;

  @override
  State<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  late List<PlayerInfo> getPlayersaData;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    getPlayersaData = await getStatistic();
    setState(() {
      isLoading = false;
    });
  }

  Future<List<PlayerInfo>> getStatistic() async {
    final uri = Uri.parse(
        "https://jankoyer.com.tm/api/1.0/game/club/${widget.id}/player/?status=football");
    var response = await http.get(uri);
    print("matchGet => ${response.statusCode}");
    var json = jsonDecode(response.body)['players'] as List;
    if (response.statusCode == 200) {
      List<PlayerInfo> statis = List<PlayerInfo>.from(
          json.map((e) => PlayerInfo.fromJson(e)));
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title:  Text(
          widget.name,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          SizedBox(height: sizeHeight*2,),
          Expanded(
            child: isLoading
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
                                "Oyunçylar ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              itemCount: getPlayersaData.length,
                              itemBuilder: (context, index) {
                                PlayerInfo  stat = getPlayersaData[index];
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
                                                  "http://jankoyer.com.tm${stat.image}"),
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
                                                stat.fullName,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
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
                        const SizedBox(height: 20,)
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

