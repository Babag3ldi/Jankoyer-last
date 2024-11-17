// ignore_for_file: override_on_non_overriding_member

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jankoyer/const/colors.dart';

import '../../../model/championat_model.dart';
import '../../../model/futbol_table_model.dart';
import 'package:http/http.dart' as http;

class FutbolTablePage extends StatefulWidget {
   const FutbolTablePage(this.champ, {super.key});

  final ChampionatModel champ;

  @override
  State<FutbolTablePage> createState() => _FutbolTablePageState();
}

class _FutbolTablePageState extends State<FutbolTablePage> {
  @override
  Future<List<TableModel>> fetchData() async {
  var url = Uri.parse('http://jankoyer.com.tm/api/1.0/game/table/club/${widget.champ.id}');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => TableModel.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return 
   
        Center( child: FutureBuilder<List<TableModel>>(
          future: fetchData(),
          builder: (context, table) {
            if (table.hasData) {
              return SizedBox(
            width: sizeWidth * 93,
            child: Column(
              children: [
                Container(
                  height: sizeHeight * 3,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: sizeWidth * 52,
                        child: const Text(
                          "KLUB",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      const Text(
                        "O",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        "Ý",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        "D",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        "U",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Padding(
                        padding:  EdgeInsets.only(right: 5.0),
                        child: Text(
                          "B",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: table.data!.length,
                    itemBuilder: (context, index) {
                      // FutbolTableModel getFotbolTableModel = tableModelList[index];
                      final tables = table.data![index];
                      return Container(
                        alignment: Alignment.center,
                        height: sizeHeight * 6,
                        decoration: const BoxDecoration(
                          color: AppColors.tabPossive,
                        ),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: sizeWidth * 7,
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: sizeHeight * 3.5,
                                    width: sizeWidth * 7,
                                    child: Center(
                                        child: Image.network(
                                            "http://jankoyer.com.tm${tables.image}"))),
                                SizedBox(
                                  width: sizeWidth * 45,
                                  child: Text(
                                    "${tables.clubName}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: sizeWidth * 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                    child: Text(
                                      "${tables.totalMatches}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "${tables.win}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "${tables.draw}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "${tables.lose}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "${tables.score}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
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
          );
        } else if (table.hasError) {
              return Text('error:${table.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
    );
  }
}
