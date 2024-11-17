import 'dart:async';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:jankoyer/model/advertise_model.dart';

import '../const/colors.dart';

class SponsorSlider extends StatefulWidget {
  const SponsorSlider({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SponsorSliderState createState() => _SponsorSliderState();
}

class _SponsorSliderState extends State<SponsorSlider> {
  Future<List<AdvertiseModel>> fetchData() async {
    var url = Uri.parse('http://jankoyer.com.tm/api/1.0/advertise?type=0');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => AdvertiseModel.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: Card(
          child: FutureBuilder<List<AdvertiseModel>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {}
              return snapshot.hasData
                  ? CaruselList(
                      list: snapshot.data!,
                    )
                  : const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

class CaruselList extends StatefulWidget  {
  final List<AdvertiseModel> list;
  const CaruselList({super.key, required this.list});

  @override
  // ignore: library_private_types_in_public_api
  _CaruselListState createState() => _CaruselListState();
}

class _CaruselListState extends State<CaruselList> with TickerProviderStateMixin {
  // int _current = 0;

  int index = 1;
  // var _dotPosition = 0;

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
    super.initState();
  }

    @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Column(
        children: <Widget>[
          CarouselSlider(
            // height: 200.0,
            // initialPage: 0,
            // onPageChanged: (index) {
            //   setState(() {
            //     _current = index;
            //   });
            // },
            // autoPlay: true,
            // autoPlayInterval: Duration(seconds: 2),
            // reverse: false,
            items: widget.list.map((imageUrl) {
              return Builder(builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  // margin: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: const BoxDecoration(
                    color: AppColors.tabPossive,
                  ),
                  child: Image.network(
                    "http://jankoyer.com.tm${imageUrl.image}",
                    fit: BoxFit.fill,
                  ),
                );
              });
            }).toList(),
            options: CarouselOptions(
                // autoPlayAnimationDuration: Duration(seconds: 5),
                autoPlayInterval: const Duration(seconds: 3),
                autoPlay: true,
                enableInfiniteScroll: true,
                animateToClosest: true,
                pageSnapping: true,
                viewportFraction: 1,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                height: 90,
                onPageChanged: (val, carouselPageChangedReason) {
                  // setState(() {
                  //   _dotPosition = val;
                  // });
                }),
          ),
          LinearProgressIndicator(
            color: AppColors.primary,
            backgroundColor: const Color.fromARGB(255, 156, 156, 156),
            minHeight: 2,
              value: controller.value,
              semanticsLabel: 'Linear progress indicator',
            ),

          //  Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: DotsIndicator(
          //     dotsCount: widget.list.length == 0 ? 1 : widget.list.length ,
          //     position: _dotPosition,
          //     decorator: const DotsDecorator(
          //       activeColor: AppColors.primary,
          //       color: Color.fromARGB(255, 107, 107, 107),
          //       spacing: EdgeInsets.all(2),
          //       activeSize: Size(8, 8),
          //       size: Size(6, 6),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
