// ignore_for_file: unused_local_variable, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../const/colors.dart';
import '../../model/shop_model.dart';
import '../../model/magazyn_category.dart';
import 'magazin_products.dart';

class MagazinCategory extends StatefulWidget {
  const MagazinCategory(this.shopInx, {super.key});

  final ShopModel shopInx;

  @override
  State<MagazinCategory> createState() => _MagazinCategoryState();
}

class _MagazinCategoryState extends State<MagazinCategory> {
  Future<List<CategoryModel>> fetchData() async {
    var url = Uri.parse(
        'http://jankoyer.com.tm/api/1.0/shop/${widget.shopInx.id}/shop-category');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => CategoryModel.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          widget.shopInx.title,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            'Kategoriýalar',
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          Expanded(
            child: FutureBuilder<List<CategoryModel>>(
              future: fetchData(),
              builder: (context, news) {
                if (news.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: news.data!.length,
                        itemBuilder: (context, index) {
                          final categoryInx = news.data![index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MagazinProducts(
                                            categoryInx, widget.shopInx)),
                                  );
                                },
                                child: Container(
                                  height: sizeHeight * 13,
                                  width: sizeWidth * 91,
                                  decoration: BoxDecoration(
                                      color: AppColors.tabPossive,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            categoryInx.title,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              bottomRight: Radius.circular(5)),
                                          child: SizedBox(
                                            height: sizeHeight * 13,
                                            width: 140,
                                            child: Image.network(
                                              'http://jankoyer.com.tm${categoryInx.image}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                } else if (news.hasError) {
                  return Text('error:${news.error}');
                }
                return const Center(
                  child:
                      SizedBox(height: 50, child: CircularProgressIndicator()),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          onPressed: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  backgroundColor: AppColors.tabPossive,
                  titlePadding: EdgeInsets.zero,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.close,
                            color: Colors.transparent,
                          )),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Center(
                              child: Text(
                            "Jaň ediň",
                            style: TextStyle(color: Colors.white),
                          )),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  content: SizedBox(
                      height: sizeHeight * 8,
                      width: sizeWidth * 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (() {
                            setState(() {
                              _makePhoneCall(
                                  'tel:${widget.shopInx.phoneNumber}');
                            });
                          }),
                          child: Container(
                              height: sizeHeight * 5,
                              width: sizeWidth * 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: AppColors.primary)),
                              child: Center(
                                  child: Text(
                                widget.shopInx.phoneNumber,
                                style: const TextStyle(color: Colors.white),
                              ))),
                        ),
                      )
                      // ListView.builder(
                      //     padding: EdgeInsets.zero,
                      //     itemCount: 3,
                      //     itemBuilder: (context, index) {
                      //       return Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: InkWell(
                      //           onTap: (() {
                      //             setState(() {
                      //               _makePhoneCall('sms:${widget.shopInx.phoneNumber}');
                      //             });
                      //           }),
                      //           child: Container(
                      //               height: sizeHeight * 5,
                      //               width: sizeWidth * 50,
                      //               decoration: BoxDecoration(
                      //                   borderRadius: BorderRadius.circular(5),
                      //                   border:
                      //                       Border.all(color: AppColors.primary)),
                      //               child: Center(
                      //                   child: Text(
                      //                 widget.shopInx.phoneNumber,
                      //                 style: const TextStyle(color: Colors.white),
                      //               ))),
                      //         ),
                      //       );
                      //     }),
                      ),
                );
              },
            );
          },
          child: const Icon(Icons.call)),
    );
  }
}
