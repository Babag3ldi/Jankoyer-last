import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:jankoyer/const/colors.dart';

import '../../model/producct_id_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen(this.product, {super.key});
  final ProductModel product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  CarouselSliderController controller = CarouselSliderController();
  var _dotPosition = 0;

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: Text(
            widget.product.title,
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: sizeWidth * 89,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: sizeHeight * 2,
                ),
                Column(
                  children: [
                    Container(
                      width: sizeWidth * 89,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: CarouselSlider(
                        carouselController: controller,
                        items: widget.product.shopAttachments.map((e) {
                          return Container(
                            width: sizeWidth * 89,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 1, color: AppColors.primary),
                                borderRadius: BorderRadius.circular(20)),
                            // child: Image.network(
                            //   "http://jankoyer.com.tm${e.image}".trim(),
                            //   // fit: BoxFit.fill,
                            // ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "http://jankoyer.com.tm${e.image}".trim(),
                              placeholder: (context, url) => const Center(
                                  child: SizedBox(
                                      height: 40,
                                      child: CircularProgressIndicator())),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                            height: 240,
                            autoPlay: true,
                            viewportFraction: 1,
                            onPageChanged: (val, carouselPageChangedReason) {
                              setState(() {
                                _dotPosition = val;
                              });
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    DotsIndicator(
                      dotsCount: widget.product.shopAttachments.isEmpty
                          ? 1
                          : widget.product.shopAttachments.length,
                      position: _dotPosition.toInt(),
                      decorator: DotsDecorator(
                        activeColor: Colors.transparent,
                        color: AppColors.primary,
                        spacing: const EdgeInsets.all(2),
                        activeSize: const Size(20, 8),
                        size: const Size(8, 8),
                        activeShape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: AppColors.primary),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: sizeHeight * 2,
                ),
                const Divider(
                  color: AppColors.primary,
                ),
                Text(
                  widget.product.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: sizeHeight * 2,
                ),
                Text(
                  widget.product.price,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: sizeHeight * 2,
                ),
                Text(
                  widget.product.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
