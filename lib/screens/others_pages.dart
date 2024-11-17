import 'package:flutter/material.dart';
import 'package:jankoyer/screens/about_screen.dart';
import 'package:jankoyer/screens/akademiya_screen.dart';
import 'package:jankoyer/screens/magazin_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../const/colors.dart';
import 'contact_screen.dart';

class OthersPages extends StatelessWidget {
  const OthersPages({super.key});

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Başgalar',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(children: [
        SizedBox(height: sizeHeight * 1),
        container(sizeHeight, sizeWidth, 'AKADEMIÝA',
            Icons.sports_baseball_outlined, () {
          pushNewScreen(
            context,
            screen: const AkademiyaScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        }),
        container(sizeHeight, sizeWidth, 'SPORT SHOP', Icons.shopping_bag_outlined,
            () {
          pushNewScreen(
            context,
            screen: const MagazinScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        }),
        container(sizeHeight, sizeWidth, 'BIZ BARADA', Icons.info_outline, () {
          pushNewScreen(
            context,
            screen: const AboutScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        }),
        container(sizeHeight, sizeWidth, 'HABARLAŞMAK', Icons.sms_outlined, () {
          pushNewScreen(
            context,
            screen: const ContactScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        }),
      ]),
    );
  }

  InkWell container(double sizeHeight, double sizeWidth, String text,
      IconData icon, VoidCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: sizeHeight * 9,
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(color: Color.fromARGB(96, 26, 17, 65)),
        child: Row(children: [
          Container(
            width: sizeWidth * 30,
            height: sizeHeight * 9,
            decoration: const BoxDecoration(color: AppColors.primary),
            child: Icon(
              icon,
              size: 70,
            ),
          ),
          SizedBox(width: sizeWidth * 4),
          Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 26),
          )
        ]),
      ),
    );
  }
}
