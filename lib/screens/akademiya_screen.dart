// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:jankoyer/model/academy_model.dart';
import 'package:jankoyer/screens/academy_details.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../const/colors.dart';
import '../service/news_service.dart';

class AkademiyaScreen extends StatefulWidget {
  const AkademiyaScreen({super.key});

  @override
  State<AkademiyaScreen> createState() => _AkademiyaScreenState();
}

class _AkademiyaScreenState extends State<AkademiyaScreen> {
  List<AcademyModel> academyList = [];
  bool isFocusedNote = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getAcademy();
  }

  Future<void> getAcademy() async {
    try {
      academyList = await NewsService().getAcademy();
      setState(() {
        isLoading = true;
      });
    } catch (e) {
      print("academy error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text('AKADEMIÝA', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: !isLoading
          ? const CircularProgressIndicator()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: academyList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    pushNewScreen(
                      context,
                      screen: AcademyDetails(academyModel: academyList[index]),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: Container(
                    height: sizeHeight * 9,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(96, 26, 17, 65)),
                    child: Row(children: [
                      Container(
                          width: sizeWidth * 30,
                          height: sizeHeight * 9,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          decoration:
                              const BoxDecoration(color: AppColors.primary),
                          child: Image.network(
                              'http://jankoyer.com.tm${academyList[index].image}',
                              fit: BoxFit.contain)),
                      SizedBox(width: sizeWidth * 4),
                      Text(
                        academyList[index].name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22),
                      )
                    ]),
                  ),
                );
              },
            ),
    );
  }
}
