// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jankoyer/screens/magazin/product_details.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../const/colors.dart';
import '../../model/producct_id_model.dart';
import 'package:http/http.dart' as http;

import '../../model/magazyn_category.dart';
import '../../model/shop_model.dart';

class MagazinProducts extends StatefulWidget {
  const MagazinProducts(this.categoryInx, this.shopInx, {super.key});

  final CategoryModel categoryInx;
  final ShopModel shopInx;

  @override
  State<MagazinProducts> createState() => _MagazinProductsState();
}

class _MagazinProductsState extends State<MagazinProducts> {
  Future<List<ProductModel>> fetchData() async {
    var url = Uri.parse(
        'http://jankoyer.com.tm/api/1.0/shop-category/${widget.categoryInx.id}/product');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => ProductModel.fromJson(data)).toList();
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
          widget.categoryInx.title,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: FutureBuilder<List<ProductModel>>(
            future: fetchData(),
            builder: (context, news) {
              if (news.hasData) {
                return GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 28),
                    itemCount: news.data!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 15,
                      // childAspectRatio: 0.65,
                      mainAxisExtent: 240,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final product = news.data![index];
                      return GestureDetector(
                        onTap: () {
                          // CustomImageProvider customImageProvider =
                          //     CustomImageProvider(
                          //   imageUrls: List.from(product.shopAttachments.map((e) => "http://jankoyer.com.tm${e.image}"))

                          //   // "http://jankoyer.com.tm${product.shopAttachments.}",

                          // );
                          // showImageViewerPager(
                          //   backgroundColor : AppColors.tabPossive,
                          //     context,
                          //     customImageProvider,
                          //     doubleTapZoomable: true,
                          //     swipeDismissible: true,
                          //     onPageChanged: (page) {
                          // }, onViewerDismissed: (page) {
                          // });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return  ProductDetailsScreen(product);}
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.tabPossive,
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                    child: Container(
                                        width: sizeWidth * 35,
                                        height: sizeHeight * 17,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: AppColors.tabPossive,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Image.network(
                                          "http://jankoyer.com.tm${product.shopAttachments.first.image}",
                                          fit: BoxFit.cover,
                                          width: sizeWidth * 35,
                                          height: sizeHeight * 17,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    maxLines: 2,
                                    product.title,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 13),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical:5.0, horizontal: 8),
                                  child: Text(
                                    product.price,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                )
                              ]),
                        ),
                      );
                    });
              } else if (news.hasError) {
                return Text('error:${news.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
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
