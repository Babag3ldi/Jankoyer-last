// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../const/colors.dart';
import '../provider/shop.dart';
import 'magazin/magazin_category.dart';

class MagazinScreen extends StatefulWidget {
  const MagazinScreen({super.key});

  @override
  State<MagazinScreen> createState() => _MagazinScreenState();
}

class _MagazinScreenState extends State<MagazinScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ShopProvider>(context, listen: false).shopGetAll();
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
        title: const Text(
          'SPORT SHOP',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Consumer<ShopProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            final shop = value.shop;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[800]!,
                    highlightColor: Colors.grey[500]!,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: shop.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Container(
                                height: sizeHeight * 13,
                                width: sizeWidth * 91,
                                decoration: BoxDecoration(
                                    color: AppColors.tabPossive,
                                    borderRadius: BorderRadius.circular(5)),
                                
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            );
          }
          final shop = value.shop;
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Padding(
                //   padding: EdgeInsets.only(left: 18.0, top: 15, bottom: 7),
                //   child: Text(
                //     'Kategoriyalar',
                //     style: TextStyle(color: Colors.white, fontSize: 20),
                //   ),
                // ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    itemCount: shop.length,
                    gridDelegate:
                         const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15,
                      // childAspectRatio: 0.65,
                      mainAxisExtent: 145,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final shopInx = shop[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MagazinCategory(shopInx)
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.tabPossive,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.network(
                              'http://jankoyer.com.tm${shopInx.image}',
                              // fit: BoxFit.fill,
                              // width: sizeWidth * 35,
                              // height: sizeHeight * 17,
                            ),
                          ),
                        ),
                      );
                    }),
                      // child: ListView.builder(
                      //     physics: const BouncingScrollPhysics(),
                      //     padding: EdgeInsets.zero,
                      //     itemCount: shop.length,
                      //     itemBuilder: (context, index) {
                      //       final shopInx = shop[index];
                      //       return Padding(
                      //         padding: const EdgeInsets.symmetric(vertical: 10),
                      //         child: Center(
                      //           child: InkWell(
                      //             onTap: () {
                      //               Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                     builder: (context) =>
                      //                         MagazinCategory(shopInx)),
                      //               );
                      //             },
                      //             child: Container(
                      //               height: sizeHeight * 13,
                      //               width: sizeWidth * 91,
                      //               decoration: BoxDecoration(
                      //                   color: AppColors.tabPossive,
                      //                   borderRadius: BorderRadius.circular(5)),
                      //               child: Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceBetween,
                      //                   children: [
                      //                     Padding(
                      //                       padding: const EdgeInsets.symmetric(
                      //                           horizontal: 20),
                      //                       child: Text(
                      //                         '${shopInx.title}',
                      //                         style: const TextStyle(
                      //                             color: Colors.white,
                      //                             fontSize: 20),
                      //                       ),
                      //                     ),
                      //                     ClipRRect(
                      //                       borderRadius: const BorderRadius.only(
                      //                           topRight: Radius.circular(5),
                      //                           bottomRight: Radius.circular(5)),
                      //                       child: SizedBox(
                      //                         height: sizeHeight * 13,
                      //                         width: 140,
                      //                         child: Image.network(
                      //                           'http://jankoyer.com.tm${shopInx.image}',
                      //                           fit: BoxFit.cover,
                      //                         ),
                      //                       ),
                      //                     )
                      //                   ]),
                      //             ),
                      //           ),
                      //         ),
                      //       );
                      //     }),
                    )),
              ]);
        },
      ),
      
    );
  }
}
